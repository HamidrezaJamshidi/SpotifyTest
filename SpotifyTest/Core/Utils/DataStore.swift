//
//  DataStore.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/27/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import Foundation
protocol DataStore: class {
    func set<Value: Codable>(data: Value, for key:  PersistentManager.Key)
    func get<Value>(for key:  PersistentManager.Key)->Value? where Value: Codable
    func remove(for key:  PersistentManager.Key)
}
