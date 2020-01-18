//
//  TrackDetailViewModel.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/28/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import UIKit

struct TrackDetailViewModel: ViewModel {
    
    let coordinator: TrackListCoordinator
    var track: Track
    
    init(coordinator: TrackListCoordinator , track: Track) {
        self.coordinator = coordinator
        self.track = track
    }

}
