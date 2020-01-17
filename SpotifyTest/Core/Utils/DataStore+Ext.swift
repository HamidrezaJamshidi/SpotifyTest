//
//  DataStore+Ext.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/27/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import Foundation

extension DataStore {

    subscript<Value:Codable>(key: PersistentManager.Key)->Value? {
        get {
            return get(for: key)
        }
        set {
            set(data: newValue , for: key)
        }
    }
}
