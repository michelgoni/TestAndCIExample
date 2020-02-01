//
//  GOTApiCase.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation

enum GOTApiCase {
    
    case getCurrency(from: String, to: String)
    case getAvailableFlights
}

extension GOTApiCase: Endpoint {
    var queryItems: [URLQueryItem]? {
       
        switch self {
        case .getCurrency(let queryElement):
            return [URLQueryItem(name: "from", value: queryElement.from),
                    URLQueryItem(name: "to", value: queryElement.to)]
        case .getAvailableFlights:
            return nil
        }
    }
    
    var base: String {
        switch self {
        case .getCurrency:
            return "http://jarvisstark.herokuapp.com/"
        case .getAvailableFlights:
            return "http://odigeo-testios.herokuapp.com/"
        }
    }
    
    var path: String? {
        
        switch self {
        case .getCurrency:
            return "/currency"
        case .getAvailableFlights:
            return nil
        }
    }
}
