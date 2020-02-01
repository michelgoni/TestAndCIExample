//
//  PersistenceTest.swift
//  DragonsTests
//
//  Created by Michel on 29/01/2020.
//  Copyright © 2020 Michel. All rights reserved.
//

import XCTest

class PersistenceTest: XCTestCase {
    
    var presenter: MockAvailableFlightsPresenter!
    var dataManager: MockAvailableFlightsDataManager!
    var completion: (Result<AvailableFlightsResponse?, ApiError>) -> () =  { _ in }
    var exchangeModelCompletion: (Result<[ExchangeModel], ApiError>) -> () =  { _ in }
    var storageManager: GOTStorageProtocol!
    
    override func setUp() {
        dataManager = MockAvailableFlightsDataManager()
        presenter = MockAvailableFlightsPresenter()
        storageManager = GOTStorageManagerMock()
    }
    
    override func tearDown() {
        presenter = nil
        dataManager = nil
        storageManager = nil
    }
    
    private func saveCurrencies() {
        let flightResponse = TestUtils.createFakeAvailableFlightResponse()
        let currencies = Set(flightResponse.results.map{$0.currency})
        storageManager.saveCurrencies(currencies: Array(currencies))
    }
    
    private func saveExchangeModel() {
        let exchangeModel = TestUtils.createExchangeModel()
        storageManager.saveExchangeValues(exchangeElements: exchangeModel)
    }
    
    private func saveCurrencyDate() {
        let date = Date()
        storageManager.saveCurrenciesDate(currenciesDate: date)
    }
    
    func testAreCurrenciesProperlySet() {
        saveCurrencies()
        XCTAssertTrue(storageManager.localCurrencies.first == "EUR")
    }
    
    func testIsExchangeModelProperlySet() {
        saveExchangeModel()
        let exchangeModel = storageManager.getExchangeValues()?.first!
        XCTAssertTrue(exchangeModel?.fromCurrencyValue == "GBP")
    }
}

struct GOTStorageManagerMock: GOTStorageProtocol {
    
    @GOTStorage(key: "currenciesMock", defaultValue: [""])
    var localCurrencies: [String]
    
    
    @GOTStorage(key: "currenciesDateMock", defaultValue: Date())
    var currenciesDate: Date
    
    @GOTStorage(key: "exchangeElementsMock", defaultValue: Data())
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
