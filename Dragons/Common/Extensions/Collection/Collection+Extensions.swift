//
//  Collection+Extensions.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation

extension Collection where Element: Comparable & Encodable {
    
    func combinationsForCurrency () -> [(from: Element, to: Element)] {
        
        var currencyCombinations = [(from: Element, to: Element)]()
        
        self.forEach { firstCurrencyValue in
            self.forEach{ secondCurrencyValue in
                if firstCurrencyValue != secondCurrencyValue {
                    currencyCombinations.append((from: firstCurrencyValue, to: secondCurrencyValue))
                }
            }
        }
        return currencyCombinations
    }
}
