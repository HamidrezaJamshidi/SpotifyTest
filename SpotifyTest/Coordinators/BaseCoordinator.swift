//
//  BaseCoordinator.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/26/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import UIKit

class BaseCoordinator: LoginCoordinator {
    private unowned var window: UIWindow
    private(set) var navigation: UINavigationController!

    init(window: UIWindow) {
        self.window = window
        start()
    }
    
    private func start(){

        let loginVC = LoginVC.init(nibName: "LoginVC", bundle: nil)
        loginVC.viewModel = LoginViewModel(coordinator: self)
        navigation = UINavigationController(rootViewController: loginVC)
        navigation.navigationBar.isHidden = true
        navigation.interactivePopGestureRecognizer?.isEnabled = false
        self.window.rootViewController = navigation
        self.window.makeKeyAndVisible()
    }
    
    func coordinateToTrackList() {
        let trackListVC = TrackListVC.init(nibName: "TrackListVC", bundle: nil)
        self.navigation.pushViewController(trackListVC, animated: true)
    }
}

protocol LoginCoordinator {
    func coordinateToTrackList()
}

protocol TrackListCoordinator {
    func coordinateToDetailTrackList()
}

