//
//  AlertActions.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import UIKit

final class AlertActions: UIAlertAction {
    
    private var handler: ((UIAlertAction) -> Void)?
    
    static func defaultAction(title: String = "Ok", style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) -> AlertActions {
        let action = AlertActions(title: title,
                                  style: style,
                                  handler: handler)
        action.handler = handler
        return action
    }
    
}
