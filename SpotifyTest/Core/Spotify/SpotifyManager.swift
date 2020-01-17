//
//  SpotifyManager.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/27/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import UIKit
import RxSwift

final class SpotifyManager : SpotifyProtocol  {
    
    static let shared: SpotifyManager = .init()
    var auth = SPTAuth.defaultInstance()!
    var loginUrl: URL?
    var userId: PublishSubject<String> = PublishSubject()
    var emailId: PublishSubject<String> = PublishSubject()
    private var dataStore: DataStore = UserDefaultStore()
    private init() {}
    
    func setupSpotifyAuth() {
        auth.redirectURL     = URL(string: ServerUrl.redirectURI.rawValue)
        auth.sessionUserDefaultsKey = "current session"
        auth.clientID        = ServerUrl.clientID.rawValue
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
    }
    
    func openSpotifyRedirectUrl(url: URL) -> Bool {
        if auth.canHandle(auth.redirectURL) {
            auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error, session) in
                if error != nil {
                    print("error!")
                }
                let sessionData = NSKeyedArchiver.archivedData(withRootObject: session)
                self.dataStore.set(data: sessionData, for: .init(rawValue: "SpotifySession"))
                self.getUserConfig()
//                NotificationCenter.default.post(name: Notification.Name(rawValue: "loginSuccessfull"), object: nil)
            })
            return true
        }
        return false
    }
    
    func getUserConfig() {
        SPTUser.requestCurrentUser(withAccessToken:(SPTAuth.defaultInstance().session.accessToken)!) { (error, data) in
            guard let user = data as? SPTUser else { print("Couldn't cast as SPTUser"); return }
            guard let userId = user.canonicalUserName else { return }
            guard let email = user.emailAddress else { return }
            self.userId.onNext(userId)
            self.emailId.onNext(email)
        }
    }
}

protocol SpotifyProtocol {
    func setupSpotifyAuth()
    func openSpotifyRedirectUrl(url: URL) -> Bool
}
