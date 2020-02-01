//
//  GOTStorageManager.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation

protocol GOTStorageProtocol {
    
    mutating func saveCurrencies(currencies: [String])
    mutating func saveCurrenciesDate(currenciesDate: Date)
    mutating func saveExchangeValues(exchangeElements: [ExchangeModel])
    func getExchangeValues() -> [ExchangeModel]?
    func isValidCurrencyDate() -> Bool
    var localCurrencies: [String] {get set}
    var currenciesDate: Date {get set}
    var exchangeElements: Data? {get set}
}

struct GOTStorageManager: GOTStorageProtocol {
  
    @GOTStorage(key: "currencies", defaultValue: [""])
    var localCurrencies: [String]
    
    
    @GOTStorage(key: "currenciesDate", defaultValue: Date())
    var currenciesDate: Date
    
    @GOTStorage(key: "exchangeElements", defaultValue: Data())
    var exchangeElements: Data?
    
    mutating func saveCurrencies(currencies: [String]) {
        self.localCurrencies = currencies
    }
    
    mutating func saveCurrenciesDate(currenciesDate: Date) {
        
        if isValidDate(currenciesDate) {
            self.currenciesDate = currenciesDate
        }
    }
    
    mutating func saveExchangeValues(exchangeElements: [ExchangeModel]) {
        
       self.exchangeElements = exchangeElements.data()
    }
    
    func getExchangeValues() -> [ExchangeModel]? {
        guard let exchangeElements = exchangeElements else { return nil }
        return ExchangeModel.decodeElement(jsonData: exchangeElements, using: [ExchangeModel].self)
    }
       
    func isValidCurrencyDate() -> Bool {
        
        return exchangeElements == nil ?  false :  isValidDate(currenciesDate)
    }
    
    // MARK: - Private
    var isValidDate: (Date) -> Bool = { date in
        return Calendar.current.isDateInToday(date)
    }
}
