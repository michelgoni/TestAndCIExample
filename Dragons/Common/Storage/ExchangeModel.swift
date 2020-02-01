//
//  ExchangeModel.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation

struct ExchangeModel: Codable {
    let fromCurrencyValue: String
    let toCurrencyValue: String
    let exchangeRate: Double
}


