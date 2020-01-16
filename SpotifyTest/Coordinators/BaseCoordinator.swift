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
//    private let disposeBag = DisposeBag()
//    private var api: Api = DefaultApi()
//    private var dataStore: DataStore = UserDefaultStore()
    init(window: UIWindow) {
        self.window = window
//        DefaultTokenProvider.init(dataStore: dataStore).token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZWUwYWI5OWY1NjZlODNlZGQxOGRkOWJmMTFlMjQyYSIsInN1YiI6IjVkZjkxYzBkZDFhODkzMDAxOTdlYjNlMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.h35v-xdwyZie3teLUCT8-VLnqoW1VqbmMe7_vxMT2NM"
        start()
    }
    
    private func start(){

        let loginVC = LoginVC.init(nibName: "LoginVC", bundle: nil)
        loginVC.viewModel = LoginViewModel(coordinator: self)
        navigation = UINavigationController(rootViewController: loginVC)
        navigation.navigationBar.isHidden = true
        self.window.rootViewController = navigation
        self.window.makeKeyAndVisible()
    }
    
    func coordinateToTrackList() {
        let trackListVC = TrackListVC.init(nibName: "TrackListVC", bundle: nil)
       // trackListVC.viewModel = WatchListViewModel(store: dataStore, coordinator: self)
        self.navigation.pushViewController(trackListVC, animated: true)
    }
}

protocol LoginCoordinator {
    //    func coordinateToPeopleDetails(for people: PopularPeople)
    //    func coordinateToMovieDetails(for knownFor: KnownFor)
    func coordinateToTrackList()
}

