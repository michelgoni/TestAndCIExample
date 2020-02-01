//
//  AvailableFlightsSection.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import UIKit

class AvailableFlightsSectionViewModel: ModuledSectionModelProtocol {
 
    var headerView: UITableViewHeaderFooterView.Type = HeaderView.self
    weak var delegate: HeaderViewDelegate?
    var section: SectionTitleRepresentable
    var elements: [ModuledModelProtocol]?
    var isCollapsed: Bool = true
    
    init(elements: [ModuledModelProtocol]?, delegate: HeaderViewDelegate?, section: SectionTitleRepresentable) {
        self.elements = elements
        self.delegate = delegate
        self.section = section
    }
}



