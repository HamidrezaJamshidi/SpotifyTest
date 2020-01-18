//
//  ServiceConfig.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/27/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import Foundation

public enum ServerConfig: String {
    case clientID = "ba05b9cd59634cefa8493ac961d76ed6"
    case clientSecret = "80b7235a88264654a105a989f6775a59"
    case redirectURI = "dpg://mydigipay/"
    case loginURL = "https://accounts.spotify.com/authorize"
    case afterLoginNotificationKey = "SpotifyLoginNotification"
    case searchUrl = "https://api.spotify.com/v1/search"
    case tokenUrl = "https://accounts.spotify.com/api/token"
    case searchLimit = "10"
    case grantType = "client_credentials"
    static func searchUrl(searchString: String , token : String) -> String {
        return "https://api.spotify.com/v1/search?q=\(searchString)&type=track&limit=5&access_token=\(token)"
    }
}
