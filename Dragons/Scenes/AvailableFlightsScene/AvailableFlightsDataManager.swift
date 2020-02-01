//
//  AvailableFlightsDataManager.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright (c) 2019 Michel. All rights reserved.
//

import UIKit

protocol AvailableFlightsDataManagerProtocol: class {
    /**
     * Add here your methods for communication PRESENTER -> DATA_MANAGER
     */
    func getAvailableFlights(completion: @escaping (Result<AvailableFlightsResponse?, ApiError>) -> Void)
    func getAvailableCurrencies(completion: @escaping (Result<[ExchangeModel], ApiError>) -> Void)
    func saveCurrencies(currencies: [String])
    func saveCurrencydate()
    func getSections() -> [SectionsModuleRepresentable]?
    func setSections(sections: [SectionsModuleRepresentable])
    func getTitle() -> String
    
}

class AvailableFlightsDataManager {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private let apiClient: AvailableFlightsApiClientProtocol
    private var storageManager: GOTStorageProtocol
    private var sections: [SectionsModuleRepresentable]?
    
    
    // MARK: - Initialization
    
    init(apiClient: AvailableFlightsApiClientProtocol,
         storageManager: GOTStorageProtocol) {
        self.apiClient = apiClient
        self.storageManager = storageManager
    }
    
    private func retrieveExchangeValues(completion: @escaping (Result<[ExchangeModel], ApiError>) -> Void) {
        var exchangeElements = [ExchangeModel]()
        let dispatchGroup = DispatchGroup()
        
        storageManager.localCurrencies.combinationsForCurrency().forEach{ (from, to) in
            dispatchGroup.enter()
            apiClient.getAvailableCurrencies(apiCase: .getCurrency(from: from, to: to)) { (result) in
                switch result {
                case .success(let currencyReponse):
                    guard let currencyResponse = currencyReponse else {
                        completion(.failure(.requestFailed))
                        return}
                    exchangeElements.append(ExchangeModel(fromCurrencyValue: from,
                                                          toCurrencyValue: to,
                                                          exchangeRate: currencyResponse.exchangeRate))
                    dispatchGroup.leave()
                case .failure(let error):
                    
                    completion(.failure(error))
                    dispatchGroup.leave()
                }
                
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.storageManager.saveExchangeValues(exchangeElements: exchangeElements)
            if let exchangeModel = self.storageManager.getExchangeValues() {
                completion(.success(exchangeModel))
            }
        }
    }
}

extension AvailableFlightsDataManager: AvailableFlightsDataManagerProtocol {
    
    func getTitle() -> String {
        
        return "MAIN_SCREEN_TITLE".localized
    }
    
    func getAvailableFlights(completion: @escaping (Result<AvailableFlightsResponse?, ApiError>) -> Void) {
        apiClient.getAvailableFlights(apiCase: .getAvailableFlights, completion: completion)
    }
    
    func getAvailableCurrencies(completion: @escaping (Result<[ExchangeModel], ApiError>) -> Void) {
        if storageManager.isValidCurrencyDate(), let exchangeModel = self.storageManager.getExchangeValues() {
            completion(.success(exchangeModel))
        }else {
            retrieveExchangeValues { (result) in
                switch result {
                case .success(let exchangeModel):
                    completion(.success(exchangeModel))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }        
    }
    
    func saveCurrencies(currencies: [String]) {
        storageManager.saveCurrencies(currencies: currencies)
    }
    
    func saveCurrencydate() {
        storageManager.saveCurrenciesDate(currenciesDate: Date())
    }
    
    func setSections(sections: [SectionsModuleRepresentable]) {
        self.sections = sections
    }
    
    func getSections() -> [SectionsModuleRepresentable]? {
        return sections
    }
}

