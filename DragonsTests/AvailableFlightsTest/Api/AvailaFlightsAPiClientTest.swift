//
//  AvailaFlightsAPiClientTest.swift
//  DragonsTests
//
//  Created by Michel on 30/01/2020.
//  Copyright © 2020 Michel. All rights reserved.
//

import XCTest

class AvailaFlightsAPiClientTest: XCTestCase {
    
    var availableFlightsApiClient: AvailableFlightsApiClientProtocol!
    var expectation: XCTestExpectation!
    let url = URL(string: "http://odigeo-testios.herokuapp.com/")!
    let api = DragonsApi.shared
    override func setUp() {
       availableFlightsApiClient = AvailableFlightsApiClient()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        api.session = urlSession
        expectation = expectation(description: "Expectation")
    }

    override func tearDown() {
        availableFlightsApiClient = nil
    }
    
    func testAvailableFlighstApiClientIsRetrievingSuccesulResponse() {
    
        let path = Bundle.main.path(forResource: "availableFlightsResponse", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        MockURLProtocol.requestHandler = { request in
            
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }

        availableFlightsApiClient.getAvailableFlights(apiCase: .getAvailableFlights) { (result) in
          
            switch result {
                case .success(let availableFlightsResponse):
                    XCTAssertFalse((availableFlightsResponse?.results.isEmpty)!)
                    XCTAssertTrue(availableFlightsResponse!.results.first?.inbound.airline == "Vermithrax")
                case .failure(let error):
                    XCTFail("Received some error: \(error.errorDescription)")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func testAvailableFlighstApiClientIsRetrievingUnSuccesulResponse() {
        
        MockURLProtocol.requestHandler = { request in
            
            throw ApiError.requestFailed
        }
        
        availableFlightsApiClient.getAvailableFlights(apiCase: .getAvailableFlights) { (result) in
            
            switch result {
            case .success :
                XCTFail("Success response was not expected.")
            case .failure(let error):
                
                XCTAssertTrue(error.errorDescription == "Request failed")
                self.expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
