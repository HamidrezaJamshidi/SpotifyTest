//
//  TrackDetailVC.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/28/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import UIKit
import RxSwift

class TrackDetailVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet var back: UIButton!
    
    var trackDetailViewModel: TrackDetailViewModel!
    private(set) var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    private func setupBinding() {
        
        back.rx.tap.subscribe(onNext: {
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        titleLabel.text = trackDetailViewModel.track.name
        albumLabel.text = trackDetailViewModel.track.album
        artistLabel.text = trackDetailViewModel.track.artist
        APIManager.shared.downloadImage(trackDetailViewModel.track.img , completionHandler: { [weak self] downloadedImg in
            self?.trackImage.image = downloadedImg
        })
    }
}
