//
//  ErrorRenderingOptions.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation
import UIKit

protocol ErrorRenderingOptionsRepresentable {
    
    var title: String {get}
    var message: String {get}
    var handler: ((UIAlertAction) -> Void)? {get}
    var customActions: [UIAlertAction]? {get}
}

struct ErrorRenderingOptions: ErrorRenderingOptionsRepresentable {
    var title: String
    var message: String
    var handler: ((UIAlertAction) -> Void)?
    var customActions: [UIAlertAction]?
    
}



