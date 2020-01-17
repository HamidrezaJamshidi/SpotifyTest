//
//  ServiceConfig.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/27/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import Foundation

public enum ServerUrl: String {
    case clientID = "ba05b9cd59634cefa8493ac961d76ed6"
    case clientSecret = "80b7235a88264654a105a989f6775a59"
    case redirectURI = "dpg://mydigipay/"
    case loginURL = "https://accounts.spotify.com/authorize"
    case afterLoginNotificationKey = "SpotifyLoginNotification"
    case searchUrl = "https://api.spotify.com/v1/search"
    case searchLimit = "10"
}

extension RequestBuilder {
    static var apiLoginUrlString: String {ServerUrl.loginURL.rawValue}
    static var apiSearchUrlString: String {ServerUrl.searchUrl.rawValue}
    static var apiRedirectUrlString: String {ServerUrl.redirectURI.rawValue}
    
    convenience init(path: String) {
        let url = URL(string: "\(RequestBuilder.apiLoginUrlString)\(path)")!
        self.init(url: url)
    }
}
