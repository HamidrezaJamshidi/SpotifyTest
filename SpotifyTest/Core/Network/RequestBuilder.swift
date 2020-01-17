//
//  RequestBuilder.swift
//  SpotifyTest
//
//  Created by Hamidreza Jamshidi on 10/27/1398 AP.
//  Copyright © 1398 AP JDeveloper. All rights reserved.
//

import Foundation
public typealias HTTPHeaders = [String: String]
open class RequestBuilder: URLRequestConvertible {
    private let url: URL
    private var timeoutInterval: TimeoutInterval = .default
    private var method: HTTPMethod = .get
    private var body: Data?
    private var headers: HTTPHeaders = [:]
    private var queryItems: [URLQueryItem]? = nil
    
    public init(url: URL) {
        self.url = url
    }
    
    open func set(method: HTTPMethod) -> RequestBuilder {
        self.method = method
        return self
    }
    
    open func set(timeoutInterval: TimeoutInterval) -> RequestBuilder {
        self.timeoutInterval = timeoutInterval
        return self
    }
    
    /// - Important: Will override `Content-Type` header with `application/json`
    ///
    /// - Parameter encodable: Encodable object to encode using Encoder
    /// - Returns: Self
    open func set<T: Encodable>(encodable: T) throws -> RequestBuilder {
        self.body = try JSONEncoder().encode(encodable)
        headers["Content-Type"] = "application/json"
        return self
    }
    
    /// Will directly set body of request
    ///
    /// - Parameter body: Data
    /// - Returns: Self
    open func set(body: Data) -> RequestBuilder {
        self.body = body
        return self
    }
    
    /// Will set query params on URL
    ///
    /// - Parameter queryItems: Array of URLQueryItem
    /// - Returns: Self
    open func set(queryItems: [URLQueryItem]) -> RequestBuilder {
        self.queryItems = queryItems
        return self
    }
    
    /// - Important: might have a conflict with `set(json: JSONValue) -> RequestBuilder`
    ///
    /// - Parameter headers: [String: String] that will be injected inside current headers
    /// - Returns: Self
    open func set(headers: HTTPHeaders) -> RequestBuilder {
        headers.forEach { self.headers[$0] = $1 }
        return self
    }
    
    open func asURLRequest() throws -> URLRequest {
        let url: URL
        if let queries = queryItems,
            var urlComp = URLComponents(url: self.url, resolvingAgainstBaseURL: false) {
            urlComp.queryItems = queries
            url = urlComp.url!
        }
        else {
            url = self.url
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = timeoutInterval.rawValue
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }
}

extension RequestBuilder {
    func setDefaultHeaders() {
        self.headers.updateValue("Bearer", forKey: "Authorization")
    }
}
