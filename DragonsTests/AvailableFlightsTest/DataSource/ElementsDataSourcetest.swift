//
//  ElementsDataSourcetest.swift
//  DragonsTests
//
//  Created by Michel on 28/01/2020.
//  Copyright © 2020 Michel. All rights reserved.
//

import XCTest
import UIKit

class ElementsDataSourceTest: XCTestCase {
    
    var elementDataSource: ElementsDataSource!
    var presenter: MockAvailableFlightsPresenter!
    
    override func setUp() {
        elementDataSource = ElementsDataSource()
        presenter = MockAvailableFlightsPresenter()
    }

    override func tearDown() {
        elementDataSource = nil
    }
    
    private func setDataSource() {
        let availableFlight = TestUtils.createFakeAvailableFlightResponse()
        presenter.handleAvailableFlights(availableFlightsResponse: availableFlight)
        elementDataSource.setDataSource(elements: presenter.section)
    }
    
    func testDataSourceHasElements() {
       setDataSource()
        XCTAssertEqual(elementDataSource.elements!.count, 1, "DataSource should have correct number of elements")
    }
    
    func testNumberOfRowsWithCollapsedCells() {
        setDataSource()
        let tableView = UITableView()
        let numberOfRows = elementDataSource.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 0, "Number of rows in table should be equal than number of elements but since our eement is collapsed, it should be always 0")
    }
    
    func testCellForRowIsProperlyCalled() {
        setDataSource()
        let tableView = UITableView()
        tableView.register(AvailableFlightTableViewCell.self)
        let cell = elementDataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! AvailableFlightTableViewCell
        XCTAssertEqual(cell.airlineLabel.text!, "Vermithrax",
                       "The first cell should display a proper airline name")
    }
    
    func testTableViewSectionsIsProperlySet() {
        setDataSource()
        let tableView = UITableView()

        XCTAssertEqual(elementDataSource.numberOfSections(in: tableView), 1,
                       "TableView should have one section since we have only one element")
    }
    
    func testTableViewHasCells() {
        let controller = AvailableFlightsViewController(nibName: "AvailableFlights", bundle: nil)
            controller.loadViewIfNeeded()
        let cell = controller.tableView.dequeueReusableCell(withIdentifier: "AvailableFlightTableViewCell")
        XCTAssertNotNil(cell, "TableView should be able to dequeue cell with identifier: 'AvailableFlightTableViewCell'")
    }
}
