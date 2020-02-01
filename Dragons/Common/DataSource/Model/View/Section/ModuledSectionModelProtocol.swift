//
//  ModuledSectionModelProtocol.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import UIKit

protocol ModuledSectionModelProtocol {
    var headerView: UITableViewHeaderFooterView.Type {get}
    var delegate: HeaderViewDelegate? {get set}
    var section: SectionTitleRepresentable {get set}
    var elements: [ModuledModelProtocol]? {get}
    var rowCount: Int {get}
    var isCollapsible: Bool { get }
    var isCollapsed: Bool { get set }
}

extension ModuledSectionModelProtocol {
    
    var rowCount: Int {
        return elements?.count ?? 0
    }
    
    var isCollapsible: Bool {
        return true
    }
    
    var isCollapsed: Bool {
        return true
    }
}
