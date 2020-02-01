//
//  TestUtils.swift
//  DragonsTests
//
//  Created by Michel on 23/11/2019.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation
@testable import Dragons

final class TestUtils {
    
    static var response: AvailableFlightsResponse!
    
    static func createFakeAvailableFlightsRequestFailed() -> Result<AvailableFlightsResponse, ApiError> {
        
        return .failure(.requestFailed)
    }
    
    static func createFakeAvailableFlightsResponse() -> Result<AvailableFlightsResponse?, ApiError> {
        
        let path = Bundle.main.path(forResource: "availableFlightsResponse", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        response = try! JSONDecoder().decode(AvailableFlightsResponse.self, from: data)
        
        return .success(response)
    }
    
    static func createFakeAvailableFlightResponse() -> AvailableFlightsResponse {
          
          let path = Bundle.main.path(forResource: "availableFlightsResponse", ofType: "json")
          let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
          response = try! JSONDecoder().decode(AvailableFlightsResponse.self, from: data)
          
          return response
      }
    
    
    static func createAvailableCurrencies() -> Set<String> {
        return ["EUR", "JPY", "USD", "GBP"]
    }
    
    static func createExchangeModel() -> [ExchangeModel] {
        
        return [ExchangeModel(fromCurrencyValue: "GBP", toCurrencyValue: "JPY", exchangeRate: 142.8677756554072),
                ExchangeModel(fromCurrencyValue: "GBP", toCurrencyValue: "EUR", exchangeRate: 1.1858216058195663),
                ExchangeModel(fromCurrencyValue: "GBP", toCurrencyValue: "USD", exchangeRate: 1.3074151356835428),
                ExchangeModel(fromCurrencyValue: "USD", toCurrencyValue: "GBP", exchangeRate:  0.764868),
                ExchangeModel(fromCurrencyValue: "USD", toCurrencyValue: "JPY", exchangeRate: 109.27498983),
                ExchangeModel(fromCurrencyValue: "USD", toCurrencyValue: "EUR", exchangeRate: 0.906997),
                ExchangeModel(fromCurrencyValue: "JPY", toCurrencyValue: "GBP", exchangeRate: 0.006999479031660506),
                ExchangeModel(fromCurrencyValue: "JPY", toCurrencyValue: "USD", exchangeRate: 0.009151224827892535),
                ExchangeModel(fromCurrencyValue: "JPY", toCurrencyValue: "EUR", exchangeRate: 0.008300133465224045),
                ExchangeModel(fromCurrencyValue: "EUR", toCurrencyValue: "USD", exchangeRate: 1.1025394791824008),
                ExchangeModel(fromCurrencyValue: "EUR", toCurrencyValue: "GBP", exchangeRate: 0.8432971663632846),
                ExchangeModel(fromCurrencyValue: "EUR", toCurrencyValue: "JPY", exchangeRate: 120.47999037483034)]
      
    }
    
    static func createDictionaryFromAvailableFlightsResponse() -> [String : [AvailableFlightResponse]] {
        return Dictionary(grouping: createFakeAvailableFlightResponse().results) { $0.inbound.originAndDestination}
    }
    
    
}
