//
//  ViewModelHolder.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/26/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import UIKit
protocol ViewModel {}
protocol ViewModelHolder where Self: UIViewController {
    associatedtype ViewModel
    var viewModel: ViewModel! {get set}
    func validateViewModel()
}

extension ViewModelHolder {
    func validateViewModel() {
        guard viewModel != nil else {
            fatalError("ViewModel is not set")
        }
    }
}
