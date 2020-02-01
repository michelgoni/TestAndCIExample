//
//  ApiError.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation

enum ApiError: Error, LocalizedError {
    
    case requestFailed
    case jsonParsingFailure
    case invalidData
    case responseUnsuccessful
    case custom(code: Int, message: String)
    
    var errorDescription: String {

        switch self {
        case .requestFailed: return "Request failed"
        case .jsonParsingFailure: return "JSON Parsing failure"
        case .invalidData: return "Invalid data from server"
        case .responseUnsuccessful: return "Reponse was not what we expected"
        case .custom(code: _, message: let message): return message
            
        }
    }
}

