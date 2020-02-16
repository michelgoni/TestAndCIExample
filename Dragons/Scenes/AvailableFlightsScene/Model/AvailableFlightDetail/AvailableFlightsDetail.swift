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
    var airline: String {get}
    var flightDescription: String {get}
    var departureDate: String {get}
    var returnDate: String {get}
    var departureTime: String {get}
    var returnTime: String {get}
    var price: String {get}
}

struct availableFlighstDetail: AvailableFlightsDetailPresentable {
    var flightsDetail: [AvailableFlightDetailRepresentable]
}

struct AvailableFlightDetail: AvailableFlightDetailRepresentable  {
    var cellType: UITableViewCell.Type = AvailableFlightTableViewCell.self
    var airline: String
    var flightDescription: String
    var departureDate: String
    var returnDate: String
    var returnTime: String
    var departureTime: String
    var price: String
}
