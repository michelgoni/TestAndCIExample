//
//  ErrorRenderer.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import UIKit

protocol ErrorRenderer {
    
    func showDefaultAlert(options: ErrorRenderingOptionsRepresentable)
    func showCustomAlert(options: ErrorRenderingOptionsRepresentable)
}

extension ErrorRenderer where Self: BaseViewController {
    
    func showDefaultAlert(options: ErrorRenderingOptionsRepresentable) {
        
        let alert = UIAlertController(title: options.title, message: options.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: options.handler))
        present(alert, animated: true)
    }
    
    func showCustomAlert(options: ErrorRenderingOptionsRepresentable) {
        let alert = UIAlertController(title: options.title, message: options.message, preferredStyle: .alert)
        options.customActions?.forEach{alert.addAction($0)}
        present(alert, animated: true)
    }
}
