//
//  AvailableFlightViewModel.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import UIKit


class AvailableFlightsViewModel {

    // MARK: - ModuledModelProtocol
  
    var elements: AvailableFlightsDetailPresentable?
    
    init(elements: AvailableFlightsDetailPresentable?) {
        self.elements = elements
    }
}

