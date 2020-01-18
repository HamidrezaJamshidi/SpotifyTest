//
//  DataStore.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/27/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import Foundation

class DataStore: NSObject {
    
    // MARK: - Shared Instance
    
    static let shared: DataStore = {
        let instance = DataStore()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    
    override init() {
        super.init()
    }
    
    public func setPref(_ key: String?, value: String?) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key ?? "")
        defaults.synchronize()
    }
    
    public func getStringPref(_ key: String?) -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: key ?? "")
    }
    
    public func removePref(_ key: String?) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key ?? "")
    }
    
    //**************Encoadable Data***************
    public func saveEncodable <T : Encodable> (name : T , key : String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(name) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    public func getDecodable <T : Decodable> (key : String , as type : T.Type) -> T? {
        let decoder = JSONDecoder()
        guard let  data = UserDefaults.standard.data(forKey: key),
            let result = try? decoder.decode(type, from: data) else {return nil}
        return result
    }

}


