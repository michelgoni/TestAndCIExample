//
//  String+Extensions.swift
//  Dragons
//
//  Created by Michel on 30/01/2020.
//  Copyright © 2020 Michel. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localizeWithFormat(arguments: [CVarArg]) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}

