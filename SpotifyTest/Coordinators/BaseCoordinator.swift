//
//  BaseCoordinator.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/26/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import UIKit

class BaseCoordinator: TrackListCoordinator {
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
//        let trackListVC = TrackListVC.init(nibName: "TrackListVC", bundle: nil)
//        navigation = UINavigationController(rootViewController: trackListVC)
        let loginVC = LoginVC.init(nibName: "LoginVC", bundle: nil)
        navigation = UINavigationController(rootViewController: loginVC)
        self.window.rootViewController = navigation
        self.window.makeKeyAndVisible()
//        peopleViewController.viewModel = PopularPeopleViewModel(store: dataStore, api: api, coordinator: self)
    }
    
//    func coordinateToWatchList() {
//        let vc = WatchListViewController.init(nibName: "WatchListViewController", bundle: nil)
//        vc.viewModel = WatchListViewModel(store: dataStore, coordinator: self)
//
//        self.navigation.pushViewController(vc, animated: true)
//    }
}

protocol TrackListCoordinator {
//    func coordinateToPeopleDetails(for people: PopularPeople)
//    func coordinateToMovieDetails(for knownFor: KnownFor)
//    func coordinateToWatchList()
}

