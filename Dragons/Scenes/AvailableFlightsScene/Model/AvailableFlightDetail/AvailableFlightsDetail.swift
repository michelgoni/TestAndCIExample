//
//  AvailableFlightsDetail.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import UIKit

protocol AvailableFlightsDetailPresentable {
    var flightsDetail: [AvailableFlightDetailRepresentable] {get}
}

protocol AvailableFlightDetailRepresentable: ModuledModelProtocol {
    var airline: TextConfigurableProtocol {get}
    var flightDescription: TextConfigurableProtocol {get}
    var departureDate: TextConfigurableProtocol {get}
    var returnDate: TextConfigurableProtocol {get}
    var departureTime: TextConfigurableProtocol {get}
    var returnTime: TextConfigurableProtocol {get}
    var price: TextConfigurableProtocol {get}
}

struct availableFlighstDetail: AvailableFlightsDetailPresentable {
    var flightsDetail: [AvailableFlightDetailRepresentable]
}

struct AvailableFlightDetail: AvailableFlightDetailRepresentable  {
    var cellType: UITableViewCell.Type = AvailableFlightTableViewCell.self
    var airline: TextConfigurableProtocol
    var flightDescription: TextConfigurableProtocol
    var departureDate: TextConfigurableProtocol
    var returnDate: TextConfigurableProtocol
    var returnTime: TextConfigurableProtocol
    var departureTime: TextConfigurableProtocol
    var price: TextConfigurableProtocol
}
