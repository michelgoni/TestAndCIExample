//
//  Currency.swift
//  Dragons
//
//  Created by Michel on 30/01/2020.
//  Copyright © 2020 Michel. All rights reserved.
//

import Foundation

enum Currency: String, CustomStringConvertible {
    
    case EUR
    
    var description: String {
        switch self {
        case .EUR:
            return "€"
        }
    }
    
    
   
}
