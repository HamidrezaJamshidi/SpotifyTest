//
//  SpotifyManager.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/27/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import UIKit
import RxSwift
import SafariServices

final class SpotifyManager : SpotifyProtocol  {
    
    static let shared: SpotifyManager = .init()
    var auth = SPTAuth.defaultInstance()!
    var loginUrl: URL?
    var userId: PublishSubject<String> = PublishSubject()
    var emailId: PublishSubject<String> = PublishSubject()
    var isLoginsucceed: PublishSubject<Bool> = PublishSubject()
    var session: SPTSession!
    
    
    private init() {}
    
    private func configSpotifyAuth() {
        auth.redirectURL     = URL(string: ServerConfig.redirectURI.rawValue)
        auth.sessionUserDefaultsKey = "current session"
        auth.clientID        = ServerConfig.clientID.rawValue
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
    }
    
    func openSpotifyRedirectUrl(url: URL) -> Bool {
        if auth.canHandle(auth.redirectURL) {
            auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error, session) in
                if error != nil {
                    print("error!")
                }
                if let session = session {
                    let userDefaults = UserDefaults.standard
                    let sessionData = NSKeyedArchiver.archivedData(withRootObject: session)
                    userDefaults.set(sessionData, forKey: "SpotifySession")
                    userDefaults.synchronize()
                    self.session = session
                    self.getUserConfig(accessToken: session.accessToken)
                    DataStore.shared.setPref("IS_LOGIN", value: "1")
                    DataStore.shared.setPref("ACCESS_TOKEN", value: session.accessToken)
                    UIApplication.topViewController?.dismiss(animated: true, completion: nil)
                    self.isLoginsucceed.onNext(true)
                }
            })
            return true
        }
        return false
    }
    
    func getUserConfig(accessToken: String) {
        SPTUser.requestCurrentUser(withAccessToken:accessToken) { (error, data) in
            guard let user = data as? SPTUser else { print("Couldn't cast as SPTUser"); return }
            guard let userId = user.canonicalUserName else { return }
            self.userId.onNext(userId)
            guard let email = user.emailAddress else { return }
            self.emailId.onNext(email)
        }
    }
    
    func loginSpotify() {
        
        configSpotifyAuth()
        if auth.session != nil {
            if auth.session.isValid() {
                self.isLoginsucceed.onNext(true)
                return
            }
            refreshToken()
            return
        }
        
        if SPTAuth.supportsApplicationAuthentication() {
            UIApplication.shared.open(auth.spotifyAppAuthenticationURL(), options: [:], completionHandler: nil)
        } else {
            let safari = SFSafariViewController(url: auth.spotifyWebAuthenticationURL())
            UIApplication.topViewController?.present(safari, animated: true, completion: nil)
        }
    }

    func refreshToken() {
        
        auth.renewSession(auth.session) { (error, session) in
            self.auth.session = session
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
}

protocol SpotifyProtocol {
    func loginSpotify()
    func refreshToken()
    func openSpotifyRedirectUrl(url: URL) -> Bool
}


//class SpotifyAuthValidation {
//
//
//    let defaults = UserDefaults.standard
//
//    static let shared = SpotifyAuthValidation()
//
//    var isLoggedIn: Bool{
//        get {
//            return defaults.bool(forKey: UserDefaults.isLoggedIn)
//        }
//        set {
//            defaults.set(newValue, forKey: UserDefaults.isLoggedIn)
//        }
//    }
//
//    var tokenId: String? {
//        get {
//            return defaults.value(forKey: UserDefaults.tokenId) as? String
//        } set {
//            defaults.set(newValue, forKey: UserDefaults.tokenId)
//        }
//}
//    var sessiontokenId: String? {
//        get {
//            return defaults.value(forKey: UserDefaults.sessiontokenId) as? String
//        } set {
//            defaults.set(newValue, forKey: UserDefaults.sessiontokenId)
//        }
//    }
//    var sessionuserId: String? {
//        get {
//            return defaults.value(forKey: UserDefaults.sessionuserId) as? String
//        } set {
//            defaults.set(newValue, forKey: UserDefaults.sessionuserId)
//        }
//    }
//}
