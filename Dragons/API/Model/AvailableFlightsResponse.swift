//
//  AvailableFlightsResponse.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//


import Foundation

// MARK: - AvailableFlightsResponse
struct AvailableFlightsResponse: Codable {
    let results: [AvailableFlightResponse]
}

// MARK: - Result
struct AvailableFlightResponse: Codable {
    let inbound: Bound
    let outbound: Bound
    let price: Double
    let currency: String
    
    func getAirline() -> TextConfigurableProtocol {
        
        return TextStyles.flightHeaderDescription(text: inbound.airline)
    }
    
    func getFlightdescription() ->TextConfigurableProtocol {
        return TextStyles.flightHeaderDescription(text: inbound.origin + inbound.destination)
    }
    
    func getDepartureDate() ->TextConfigurableProtocol {
        return TextStyles.flightHeaderPrice(text: inbound.departureDate)
    }
    
    func getReturnDate() -> TextConfigurableProtocol {
         return TextStyles.flightHeaderPrice(text: inbound.arrivalDate)
    }
    
    func getReturnTime() -> TextConfigurableProtocol {
         return TextStyles.flightHeaderPrice(text: inbound.arrivalTime)
    }
    
    func getDepartureTime() -> TextConfigurableProtocol {
        return TextStyles.flightHeaderPrice(text: inbound.departureTime)
    }
    
    func getPrice(price: Double) -> TextConfigurableProtocol {
        return TextStyles.flightPrice(text: "\(String(format: "%.2f", price)) €")
    }
    
    func getAvailableFlightDetail(price: Double) -> AvailableFlightDetailRepresentable {
    
        return AvailableFlightDetail(airline: getAirline(),
                                      flightDescription: getFlightdescription(),
                                      departureDate: getDepartureDate(),
                                      returnDate: getReturnDate(),
                                      returnTime: getReturnTime(),
                                      departureTime: getDepartureTime(),
                                      price: getPrice(price: price))
    }
}

// MARK: - Bound
struct Bound: Codable {
    let airline: String
    let airlineImage: String
    let arrivalDate: String
    let arrivalTime: String
    let departureDate: String
    let departureTime: String
    let destination: String
    let origin: String
    var originAndDestination: String {
        return origin + "-" + destination
    }
}
