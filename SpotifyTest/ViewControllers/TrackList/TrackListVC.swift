//
//  TrackListVC.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/26/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import UIKit
import RxSwift

class TrackListVC: UIViewController {

    
    @IBOutlet var txtSearchBar: UITextField!
    @IBOutlet private var tableView: UITableView! {
        didSet {
            self.tableView.register(UINib(nibName: "TrackListCell", bundle: nil), forCellReuseIdentifier: "TrackListCell")
            self.tableView.tableFooterView = UIView()
            self.tableView.separatorStyle = .none
        }
    }
    @IBOutlet private var loadingView: UIActivityIndicatorView!
    
    var reachability: Reachability?
    var trackListViewModel: TrackListViewModel!
    private(set) var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Reachability.rx.isDisconnected
            .subscribe(onNext:{
//                let error = MessageView.viewFromNib(layout: .tabView)
//                error.configureTheme(.error)
//                error.configureContent(title: "Error", body: "Not connected to the network!")
//                error.button?.setTitle("Stop", for: .normal)
//                SwiftMessages.show(view: error)
            })
            .disposed(by:disposeBag)
    }


    private func setupBinding() {
        
        txtSearchBar.becomeFirstResponder()
        trackListViewModel.trackList.bind(to: tableView.rx.items(cellIdentifier: "TrackListCell", cellType: TrackListCell.self)) { (row,item,cell) in
            self.configureCell(cell: cell, item: item)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let item:Track = try! self?.tableView.rx.model(at: indexPath) else { return }
            self?.trackListViewModel.coordinator.coordinateToTrackDetail(for: item)
        }).disposed(by: disposeBag)

        
        txtSearchBar
            .rx
            .controlEvent(.editingChanged)
            .withLatestFrom(txtSearchBar.rx.text.orEmpty)
            .throttle(DispatchTimeInterval.seconds(3), latest: false, scheduler: MainScheduler.instance)
            .map { $0 }
            .subscribe(onNext: { [weak self] (text) in
                print(text)
                self?.trackListViewModel.search(query: text)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
        
    }
    
    private func configureCell(cell: TrackListCell , item: Track) {
        cell.titleLabel.text = item.name
        cell.albumLabel.text = item.album
        cell.artistLabel.text = item.artist
        APIManager.shared.downloadImage(item.img , completionHandler: { downloadedImg in
            cell.trackImage.image = downloadedImg
        })
    }
}
