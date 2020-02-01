//
//  UILabel+Extensions.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2020 Michel. All rights reserved.
//

import UIKit

extension UILabel {
    
    func configure(textConfigurable: TextConfigurableProtocol?) {
        if let textConfigurable = textConfigurable {
            text = textConfigurable.text
            font = textConfigurable.font
            textColor = textConfigurable.color
            textAlignment = textConfigurable.alignment
        } else {
            text = ""
        }
    }
    
}

