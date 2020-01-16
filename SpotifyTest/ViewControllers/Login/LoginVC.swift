//
//  LoginVC.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/26/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: UIViewController {

    @IBOutlet var imgLogo: UIImageView!
    @IBOutlet var btnSignIn: UIButton!
    
    var viewModel: LoginViewModel!
    private(set) var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    
    private func setupUI() {
        DispatchQueue.main.async {
            self.viewModel.animateLogo(refView: self.view, img: self.imgLogo)
        }
    }
    
    private func setupBinding() {
        btnSignIn.rx.tap.subscribe(onNext: {
        }).disposed(by: disposeBag)
    }
    
     
}
