//
//  AvailableFlightsSectionRepresentable.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation

struct AvailableFlightsSection: SectionsModuleRepresentable {
    
    // MARK: - SectionsModuleRepresentable
    
    var sectionElement: ModuledSectionModelProtocol
    
    init(sectionElement: ModuledSectionModelProtocol) {
        self.sectionElement = sectionElement
    }
}
