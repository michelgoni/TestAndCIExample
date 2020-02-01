//
//  TextConfigurable.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2020 Michel. All rights reserved.
//

import UIKit

protocol TextConfigurableProtocol {
    var text: String { get set }
    var font: UIFont { get set }
    var color: UIColor { get set }
    var alignment: NSTextAlignment { get set }
}

struct TextConfigurable: TextConfigurableProtocol {
    var text: String
    var font: UIFont
    var color: UIColor
    var alignment: NSTextAlignment
    
}

