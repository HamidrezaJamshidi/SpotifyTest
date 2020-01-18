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
    var trackListViewModel = TrackListViewModel()
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
        
        trackListViewModel.trackList.bind(to: tableView.rx.items(cellIdentifier: "TrackListCell", cellType: TrackListCell.self)) { (row,item,cell) in
            self.configureCell(cell: cell, item: item)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(TrackListCell.self).subscribe(onNext: { item in
           // print("SelectedItem: \(item.name)")
        }).disposed(by: disposeBag)
        
//        trackListViewModel.trackList.bind(to: tableView.rx.items) {(tv, row, item) -> UITableViewCell in
//
//            let cell = tv.dequeueReusableCell(withIdentifier: "TrackListCell", for: IndexPath(row: row, section: 0)) as! TrackListCell
//
//            cell.lblDeviceName.text = item.deviceModel
//            cell.lblDeviceOS.text = (item.deviceType ?? "") + "," + (item.osVersion ?? "")
//            cell.lblDate.text = item.dateCreated
//            cell.lblIpAddress.text = item.ipAddress
//
//            cell.subscribeBtnAction = { [unowned self] in
//                self.idForDelete = item.id
//                print(row)
//                self.showPopupAlertWith(viewController: self, title:ConstantStrings.popSessionTitle , descMsg: ConstantStrings.popSessionInfo, img: PopupConstant.imgDefaultStr, lineColor: ConstantStrings.customGrayEnd, isHideButton: false)
//            }
//
//            return cell
//        }.disposed(by: disposeBag)
        
        txtSearchBar
            .rx
            .controlEvent(.editingChanged)
            .withLatestFrom(txtSearchBar.rx.text.orEmpty)
            .map { $0 }
            .subscribe(onNext: { (text) in
                print(text)
                self.trackListViewModel.search(query: text)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
        
        txtSearchBar.rx.controlEvent(.editingDidBegin).subscribe(onNext: {
  
        }).disposed(by: disposeBag)
        
        txtSearchBar.rx.controlEvent(.editingDidEnd).subscribe(onNext: {
            
        }).disposed(by: disposeBag)

    }
    
    private func configureCell(cell: TrackListCell , item: Track) {
        cell.titleLabel.text = item.artist
        cell.albumLabel.text = item.album
        cell.artistLabel.text = item.name
        cell.trackImage.downloaded(from: item.img)
    }
}
