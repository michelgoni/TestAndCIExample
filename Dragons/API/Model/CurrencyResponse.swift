//
//  CurrencyResponse.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation

struct CurrencyResponse: Codable {
    let currency: String
    let exchangeRate: Double
}
