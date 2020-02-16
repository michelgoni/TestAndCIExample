//
//  AvailableFlightTableViewCell.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import UIKit

class AvailableFlightTableViewCell: UITableViewCell, Nibable, ConfigurableModuledModel {
  
    @IBOutlet weak var flightDescriptionLabel: UILabel!
    @IBOutlet weak var airlineLabel: UILabel!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var arrivalDateLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    // MARK: - ConfigurableModuledModel
     func configure(element: ModuledModelProtocol) {
        if let availableFlighsdetail = element as? AvailableFlightDetailRepresentable {
            
            flightDescriptionLabel.configure(textConfigurable: TextStyles.flightHeaderDescription(text: availableFlighsdetail.flightDescription))
            airlineLabel.configure(textConfigurable: TextStyles.flightHeaderDescription(text: availableFlighsdetail.airline))
            departureLabel.configure(textConfigurable: TextStyles.flightHeaderDescription(text: "Departure"))
            departureDateLabel.configure(textConfigurable: TextStyles.flightHeaderPrice(text: availableFlighsdetail.departureDate))
            departureTimeLabel.configure(textConfigurable: TextStyles.flightHeaderPrice(text: availableFlighsdetail.departureTime))
            arrivalLabel.configure(textConfigurable: TextStyles.flightHeaderDescription(text: "Arrival"))
            arrivalDateLabel.configure(textConfigurable: TextStyles.flightHeaderPrice(text: availableFlighsdetail.returnDate))
            arrivalTimeLabel.configure(textConfigurable: TextStyles.flightHeaderPrice(text: availableFlighsdetail.returnTime))
            priceLabel.configure(textConfigurable: TextStyles.flightPrice(text: availableFlighsdetail.price))
        }
    }
}
