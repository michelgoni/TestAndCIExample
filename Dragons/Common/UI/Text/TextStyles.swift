//
//  TextStyles.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2020 Michel. All rights reserved.
//

import UIKit

struct TextStyles {
    
    static func flightHeaderDescription(text: String) -> TextConfigurable {
        return TextConfigurable(text: text, font: UIFont.geogrotesqueMedium24(), color: .black, alignment: .left)
    }
    
    static func flightHeaderPrice(text: String) -> TextConfigurable {
        return TextConfigurable(text: text, font: UIFont.geogrotesqueRegular16(), color: .black, alignment: .left)
    }
    
    static func flightPrice(text: String) -> TextConfigurable {
        return TextConfigurable(text: text, font: UIFont.geogrotesqueMedium30(), color: .black, alignment: .right)
    }
    
    static func flightCurrency(text: String) -> TextConfigurable {
        return TextConfigurable(text: text, font: UIFont.geogrotesqueRegular14(), color: .black, alignment: .right)
    }
    
}

