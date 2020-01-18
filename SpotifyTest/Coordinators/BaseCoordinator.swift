//
//  BaseCoordinator.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/26/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import UIKit

class BaseCoordinator: LoginCoordinator , TrackListCoordinator {
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
        trackListVC.trackListViewModel = TrackListViewModel(coordinator: self)
        self.navigation.pushViewController(trackListVC, animated: true)
    }
    
    func coordinateToTrackDetail(for track: Track) {
        let trackDetailVC = TrackDetailVC.init(nibName: "TrackDetailVC", bundle: nil)
        trackDetailVC.trackDetailViewModel = TrackDetailViewModel(coordinator: self, track: track)
        self.navigation.pushViewController(trackDetailVC, animated: true)
    }

}

protocol LoginCoordinator {
    func coordinateToTrackList()
}

protocol TrackListCoordinator {
    func coordinateToTrackDetail(for track: Track)
}

