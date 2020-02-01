//
//  Nibable.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import UIKit

protocol Nibable {
    var nib: UINib {get}
    var identifier: String {get}
}

extension Nibable where Self: UIView {
    
    var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var identifier: String {
        return String(describing: self)
    }
}

