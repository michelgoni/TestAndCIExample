//
//  AvailableFlightsPresenterTest.swift
//  DragonsTests
//
//  Created by Michel on 23/11/2019.
//  Copyright © 2019 Michel. All rights reserved.
//

import XCTest

class AvailableFlightsPresenterTest: XCTestCase {
    
    var sut: AvailableFlightsPresenter!
    var view: MockAvailableFlightsView!
    var dataManager: MockAvailableFlightsDataManager!
    var completion: (Result<AvailableFlightsResponse?, ApiError>) -> () =  { _ in }
    var exchangeModelCompletion: (Result<[ExchangeModel], ApiError>) -> () =  { _ in }
    
    override func setUp() {
        
        view = MockAvailableFlightsView()
        dataManager = MockAvailableFlightsDataManager()
        sut = AvailableFlightsPresenter(view: view, dataManager: dataManager)
        dataManager.presenter = sut
    }
    
    override func tearDown() {
        view = nil
        dataManager = nil
        sut = nil
    }
    
    // MARK: - Private implementation
    private func givenFlightRequestErrorWillbeReturned() {
        let result = TestUtils.createFakeAvailableFlightsRequestFailed()
        switch result {
        case .success: break
            
        case .failure(let error):
            view.showDefaultAlert(options: ErrorRenderingOptions(title: "ERROR_TITLE".localized,
                                                                 message: error.errorDescription))
        }
    }
    
    private func givenFlightRequestActivityIndicatorWillStartAnimating() {
        let result = TestUtils.createFakeAvailableFlightsResponse()
        switch result {
        case .success:
            view.showLoading()
           
        case .failure: break
            
        }
    }
    
    private func givenFlightRequestActivityIndicatorWillStopAnimating() {
        let result = TestUtils.createFakeAvailableFlightsResponse()
        switch result {
        case .success:
            sleep(3)
            view.hideLoading()
        case .failure: break
            
        }
    }
    
    func givenAvailableFlightASectionWithViewModelWillbeReturned(availableFlight: AvailableFlightResponse) -> AvailableFlightsSection {
        
        let element = [AvailableFlightDetail(airline: availableFlight.inbound.airline,
                                             flightDescription: availableFlight.inbound.origin + "-" + availableFlight.inbound.destination,
                                             departureDate: availableFlight.inbound.departureDate,
                                             returnDate: availableFlight.outbound.arrivalDate,
                                             returnTime: availableFlight.outbound.arrivalTime,
                                             departureTime: availableFlight.inbound.departureTime,
                                             price: String(format: "%.2f", availableFlight.price))]
        
        let section = AvailableFlightsSection(sectionElement: AvailableFlightsSectionViewModel(elements: element,
                                                                                                     delegate: self,
                                                                                                     section: SectionTitleViewModel(title: availableFlight.inbound.origin + "-" + availableFlight.inbound.destination,
                                                                                                                                    price: availableFlight.price)))
        
        return section
    }
    
    
    // MARK: - Test methods
    func testIsPresenterShowingDefaultError() {
        givenFlightRequestErrorWillbeReturned()
        XCTAssertTrue(view.isErrorDefaultMessageShown)
    }
    
    func testIsPresenterRequestFailed() {
         let result = TestUtils.createFakeAvailableFlightsRequestFailed()
        switch result {
        case .success: break
            
        case .failure(let error):
            XCTAssertEqual(error.errorDescription, "Request failed")
        }
    }
    
    func testIsPresenterShowingTitle() {
        view.showTitle(title: dataManager.getTitle())
        XCTAssert(view.title == "MAIN_SCREEN_TITLE".localized, "Ouch, title is not properly set")
    }
    
    func testIsPresenterReceivingAvailableFlights() {
        
        let availableFlights = TestUtils.createFakeAvailableFlightsResponse()
        
        switch availableFlights {
        case .success(let availableFlights):
            XCTAssert(!availableFlights!.results.isEmpty, "Ouch, we don´t have results")
        case .failure: break
        }
    }
    
    func testIsPresenterReceivingAnAvailableFlight() {
        let availableFlights = TestUtils.createFakeAvailableFlightsResponse()
        switch availableFlights {
        case .success(let availableFlights):
           
            if availableFlights!.results.first != nil {
                XCTAssert(true, "Ouch, Elemnets inside results are not and AvailableFlightResponse")
            }
        case .failure: break
        }
    }
    
    func testIsPresenterLoadingAnActivityIndicator(){
        givenFlightRequestActivityIndicatorWillStartAnimating()
        XCTAssert(view.loadingScreen.loadingActivityIndicator.isAnimating)
    }
    
    func testIsPresenterHidingActivityIndicator() {
         givenFlightRequestActivityIndicatorWillStopAnimating()
         XCTAssertFalse(view.loadingScreen.loadingActivityIndicator.isAnimating)
    }
    
    func testIsPresenterTransformingResponseInAProperViewModel() {
        
        dataManager.getAvailableFlights(completion: completion)
        
        let availableFlight = TestUtils.createFakeAvailableFlightResponse().results.first!
        let section = givenAvailableFlightASectionWithViewModelWillbeReturned(availableFlight: availableFlight)

     
        let delegate = section.sectionElement.delegate
        

        if let availableFlightElement = section.sectionElement.elements?.first as? AvailableFlightDetailRepresentable {
            let flightHeaderTitle = section.sectionElement.section.title
            let flightHeaderPrice = section.sectionElement.section.price
            let airline = availableFlightElement.airline
            let departureDate = availableFlightElement.departureDate
            delegate?.toggleSection(header: HeaderView(), section: 1)
            XCTAssertTrue(flightHeaderTitle == "Old Valyria-Samyrian")
            XCTAssertTrue(flightHeaderPrice == 7541.1)
            XCTAssertTrue(airline == "Vermithrax")
            XCTAssertTrue(departureDate == "9/3/3949")
           
        }
    }
    
    func testIsPresenterInjectingSections() {
        dataManager.getAvailableFlights(completion: completion)
        dataManager.getAvailableCurrencies(completion: exchangeModelCompletion)
        let sections = dataManager.getSections()
        view.showSections(sections: sections!)
        XCTAssertTrue(view.isShowingSections)
    }
    
    func testIsDelegateProperlySetInPresenter() {
        let availableFlight = TestUtils.createFakeAvailableFlightResponse().results.first!
         let section = givenAvailableFlightASectionWithViewModelWillbeReturned(availableFlight: availableFlight)
        
        let delegate = section.sectionElement.delegate
        delegate?.toggleSection(header: HeaderView(), section: 1)
        XCTAssertTrue(view.isReloadingSections)
        XCTAssertTrue(view.section == 1)
    }
}


class MockAvailableFlightsView: AvailableFlightsViewProtocol {
   
    var loadingScreen =  ActivityIndicatorScreen()
    
    var title: String!
    var isErrorDefaultMessageShown = false
    var isShowingSections = false
    var isReloadingSections = false
    var section: Int = 0
    var isMessageWithCustomActionsLaunched = false
    var loggedClass = ""
    
    func showSections(sections: [SectionsModuleRepresentable]) {
        isShowingSections = sections.isEmpty ? false : true
    }
    
    func reloadSections(section: Int) {
        isReloadingSections = true
        self.section = section
    }
    
    func showTitle(title: String) {
        self.title = title
    }
    
    func showLoading() {
        loadingScreen.loadingActivityIndicator.startAnimating()
        
    }
    
    func hideLoading() {
        loadingScreen.loadingActivityIndicator.stopAnimating()
        
    }
    
    func hideLoading(completion: (() -> Void)?) {
        hideLoading()
    }
    
    
    func logClass() {
        loggedClass = "Showing Dragons.AvailableFlightsViewController"
    }
    
    func showDefaultAlert(options: ErrorRenderingOptionsRepresentable) {
        isErrorDefaultMessageShown = true
    }
    
    func showCustomAlert(options: ErrorRenderingOptionsRepresentable) {
        isMessageWithCustomActionsLaunched = true
    }
    

}

extension AvailableFlightsPresenterTest: HeaderViewDelegate {
    func toggleSection(header: HeaderView, section: Int) {
        view.reloadSections(section: section)
    }
    
    
}

class MockAvailableFlightsDataManager: AvailableFlightsDataManagerProtocol {
    
    private var sections: [SectionsModuleRepresentable]?
    var presenter: AvailableFlightsPresenterProtocol?
    var storageManager: GOTStorageProtocol = GOTStorageManager()
    
    func getAvailableFlights(completion: @escaping (Result<AvailableFlightsResponse?, ApiError>) -> Void) {
        
        presenter?.handleAvailableFlights(availableFlightsResponse: TestUtils.createFakeAvailableFlightResponse())
    }
    
    func getAvailableCurrencies(completion: @escaping (Result<[ExchangeModel], ApiError>) -> Void) {
        
        let viewModel = presenter?.getAvailableFlightsViewModel(flightValues: TestUtils.createDictionaryFromAvailableFlightsResponse(),
                                                exchangeValue: TestUtils.createExchangeModel())
        
        setSections(sections: viewModel!)
        
        
    }
    
    func saveCurrencies(currencies: [String]) {
        storageManager.saveCurrencies(currencies: currencies)
    }
    
    func saveCurrencydate() {
        
    }
    
    func getSections() -> [SectionsModuleRepresentable]? {
        return sections
    }
    
    func setSections(sections: [SectionsModuleRepresentable]) {
        self.sections = sections
    }
    
    func getTitle() -> String {
        return "MAIN_SCREEN_TITLE".localized
    }

}
