//
//  TimeoutInterval.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/27/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import Foundation

public struct TimeoutInterval: RawRepresentable {
    public typealias RawValue = Double
    
    public var rawValue: Double
    
    public init(rawValue: Double) {
        self.rawValue = rawValue
    }
    
}

extension TimeoutInterval: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Double
    
    public init(floatLiteral: Double) {
        self.rawValue = floatLiteral
    }
}

public extension TimeoutInterval {
    static let `default`: TimeoutInterval = 15.0
}
