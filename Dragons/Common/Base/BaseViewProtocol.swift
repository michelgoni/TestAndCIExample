//
//  ClassLogger.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import UIKit

protocol BaseViewProtocol: ErrorRenderer {
    var loadingScreen: ActivityIndicatorScreen {get}
    func logClass()
    func showTitle(title: String)
    func showLoading()
    func hideLoading()
    func hideLoading(completion: (() -> Void)?)
}

class BaseViewController: UIViewController, BaseViewProtocol {
    
    var loadingScreen = ActivityIndicatorScreen()
    
    func showTitle(title: String) {
        self.title = title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logClass()
    }
    
    func showLoading() {
        loadingScreen.show(view: view)
    }
    
    func hideLoading() {
        hideLoading(completion: nil)
    }
    
    // MARK: - Class functions
    
    func hideLoading(completion: (() -> Void)? = nil) {
        loadingScreen.hide(completion: completion)
    }
}

extension BaseViewProtocol where Self: UIViewController {
    
    func logClass() {
        debugPrint("Showing " + NSStringFromClass(classForCoder))
    }
}
