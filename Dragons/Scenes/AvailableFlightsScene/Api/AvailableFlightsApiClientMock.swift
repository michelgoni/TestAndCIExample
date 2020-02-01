//
//  AvailableFlightsApiClientMock.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright (c) 2019 Michel. All rights reserved.
//

import UIKit

class AvailableFlightsApiClientMock: AvailableFlightsApiClientProtocol {

    
    func getAvailableFlights(apiCase: GOTApiCase, completion: @escaping (Result<AvailableFlightsResponse?, ApiError>) -> Void) {
        if let path = Bundle.main.path(forResource: "Home", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let response = try JSONDecoder().decode(AvailableFlightsResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.jsonParsingFailure))
            }
        }
    }
    
    func getAvailableCurrencies(apiCase: GOTApiCase, completion: @escaping (Result<CurrencyResponse?, ApiError>) -> Void) {
        if let path = Bundle.main.path(forResource: "currencies", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let response = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.jsonParsingFailure))
            }
        }
    }
    
}
