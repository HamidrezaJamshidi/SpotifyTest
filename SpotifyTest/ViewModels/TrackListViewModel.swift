//
//  TrackListViewModel.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/27/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import Foundation
import RxSwift

struct TrackListViewModel: ViewModel {
    
    let coordinator: TrackListCoordinator
    public let trackList: PublishSubject<[Track]> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    init(coordinator: TrackListCoordinator) {
        self.coordinator = coordinator
    }
    
    func search(query: String) {

        let auth: SPTAuth = SPTAuth.defaultInstance()
        let token = auth.session.accessToken
        var trackListItem = [Track]()
        
        SPTSearch.perform(withQuery: query, queryType: .queryTypeTrack, accessToken: token) { (error, listPage) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let listPage = listPage as? SPTListPage else { return }
            guard let tracks = listPage.items as? [SPTPartialTrack] else { return }
            
            for track in tracks {
                guard let album = track.album else { return }
                guard let img = track.album.largestCover else { return }
                guard let artist = track.artists.first as? SPTPartialArtist else { return }
                let track = Track(name: track.name, album: album.name, artist: artist.name, img: img.imageURL.absoluteString)
                trackListItem.append(track)
            }
            self.trackList.onNext(trackListItem)
        }
    }
}

struct Track {
    let name: String
    let artist: String
    let album: String
    let img: String
    
    init(name: String, album: String , artist: String , img: String) {
        self.name = name
        self.artist = artist
        self.album = album
        self.img = img
    }
}
