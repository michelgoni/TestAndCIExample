//
//  SectionTitleViewModel.swift
//  Dragons
//
//  Created by Michel on 06/01/2020.
//  Copyright © 2020 Michel. All rights reserved.
//

import Foundation

protocol SectionTitleRepresentable {
    var title: String {get}
    var price: Double{get}
}

struct SectionTitleViewModel: SectionTitleRepresentable {
    var title: String
    var price: Double
}
