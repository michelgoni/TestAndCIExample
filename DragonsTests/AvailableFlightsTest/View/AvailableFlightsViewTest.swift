//
//  AvailableFlightsViewTest.swift
//  DragonsTests
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import XCTest

class AvailableFlightsViewTest: XCTestCase {
    
    var sut: MockAvailableFlightsView!
    var presenter: MockAvailableFlightsPresenter!
    var dataManager: MockAvailableFlightsDataManager!
    var completion: (Result<AvailableFlightsResponse?, ApiError>) -> () =  { _ in }
    var exchangeModelCompletion: (Result<[ExchangeModel], ApiError>) -> () =  { _ in }
    
    override func setUp() {
        sut = MockAvailableFlightsView()
        dataManager = MockAvailableFlightsDataManager()
        presenter = MockAvailableFlightsPresenter()
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        dataManager = nil
    }
    
    private func baseViewControllerWillLogClass() {
        sut.logClass()
    }
    
    private func createController() -> AvailableFlightsViewController {
        let controller = AvailableFlightsViewController(nibName: "AvailableFlights", bundle: nil)
        controller.loadViewIfNeeded()
        return controller
    }
    
    func testIsViewControllerLoggingClass() {
        baseViewControllerWillLogClass()
        XCTAssertTrue(sut.loggedClass == "Showing Dragons.AvailableFlightsViewController")
    }
    
    func testHasControllerATableView() {
         XCTAssertNotNil(createController().tableView, "Controller should have a tableview")
        
    }
    
    func testTableViewDataSourceSectionsModuleRepresentable() {
        let controller = createController()
        let availableFlight = TestUtils.createFakeAvailableFlightResponse()
        presenter.handleAvailableFlights(availableFlightsResponse: availableFlight)
        let dataSource = ElementsDataSource()
        dataSource.setDataSource(elements: presenter.section)
        controller.tableView.dataSource = dataSource
        controller.tableView.delegate = dataSource
        XCTAssertTrue(controller.tableView.dataSource is ElementsDataSource)
        XCTAssertTrue(controller.tableView.delegate is ElementsDataSource)
    }
    
    func testViewDidLoad() {
        presenter.viewDidLoad()
        XCTAssertTrue(presenter.timeToLoadThingAfterViewIsLoad)
    }
    
    func testViewIsShowingTitle() {
        presenter.getTitle()
        XCTAssert(presenter.title == "MAIN_SCREEN_TITLE".localized)
        XCTAssertTrue(presenter.titleIsLoaded)
    }
    
}

class MockAvailableFlightsPresenter: AvailableFlightsPresenterProtocol {
    
    private var price: Double!
    private var values: [AvailableFlightDetailRepresentable]!
    var section: [SectionsModuleRepresentable]!
    var timeToLoadThingAfterViewIsLoad = false
    var titleIsLoaded = false
    var title = ""
    
    private func givenAvailableFlightASectionWithViewModelWillbeReturned(availableFlight: AvailableFlightResponse) -> AvailableFlightsSection {
        
        let element = [AvailableFlightDetail(airline: availableFlight.inbound.airline,
                                             flightDescription: availableFlight.inbound.origin + "-" + availableFlight.inbound.destination,
                                             departureDate: availableFlight.inbound.departureDate,
                                             returnDate: availableFlight.outbound.arrivalDate,
                                             returnTime: availableFlight.outbound.arrivalTime,
                                             departureTime: availableFlight.inbound.departureTime,
                                             price: String(format: "%.2f", availableFlight.price))]
        
        let section = AvailableFlightsSection(sectionElement: AvailableFlightsSectionViewModel(elements: element,
                                                                                                     delegate: nil,
                                                                                                     section: SectionTitleViewModel(title: availableFlight.inbound.origin + "-" + availableFlight.inbound.destination,
                                                                                                                                    price: availableFlight.price)))
        
        return section
    }
    
    func viewDidLoad() {
        timeToLoadThingAfterViewIsLoad = true
    }
    
    func getTitle() {
        title = "MAIN_SCREEN_TITLE".localized
        titleIsLoaded = true
    }
    
    func handleAvailableFlights(availableFlightsResponse: AvailableFlightsResponse) {
        let section = getAvailableFlightsViewModel(flightValues: TestUtils.createDictionaryFromAvailableFlightsResponse(), exchangeValue: TestUtils.createExchangeModel())
        self.section = section
    }
    
    func getAvailableFlightsViewModel(flightValues: [String : [AvailableFlightResponse]], exchangeValue: [ExchangeModel]) -> [SectionsModuleRepresentable] {
        
        var sections = [SectionsModuleRepresentable]()
        
        let availableFlight = TestUtils.createFakeAvailableFlightResponse().results.first!
        
         let section = givenAvailableFlightASectionWithViewModelWillbeReturned(availableFlight: availableFlight)
         sections.append(section)

        return sections
    }
}
