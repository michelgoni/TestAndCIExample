//
//  AvailableFlightsApiClient.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright (c) 2019 Michel. All rights reserved.
//

import UIKit

protocol AvailableFlightsApiClientProtocol {
    
    func getAvailableFlights(apiCase: GOTApiCase,completion: @escaping (Result<AvailableFlightsResponse?, ApiError>) -> Void)
    func getAvailableCurrencies(apiCase: GOTApiCase, completion: @escaping (Result<CurrencyResponse?, ApiError>) -> Void)
}

class AvailableFlightsApiClient: AvailableFlightsApiClientProtocol {
    
    func getAvailableFlights(apiCase: GOTApiCase, completion: @escaping (Result<AvailableFlightsResponse?, ApiError>) -> Void) {
        
        DragonsApi.shared.getAvailableFlights(request: apiCase.request, completion: completion)
    }
    
    func getAvailableCurrencies(apiCase: GOTApiCase, completion: @escaping (Result<CurrencyResponse?, ApiError>) -> Void) {
        DragonsApi.shared.getCurrency(request: apiCase.request, completion: completion)
    }
}
