//
//  Endpoint.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String? { get }
    var queryItems: [URLQueryItem]? {get}
}

extension Endpoint {
    
    var urlComponents: URLComponents {
        guard var components = URLComponents(string: base) else {
            fatalError("Sorry, but there must be a valid endPoint")
        }
        components.path = path ?? ""
        components.queryItems = queryItems
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
