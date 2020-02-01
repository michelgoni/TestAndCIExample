//
//  AppDelegate.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        AvailableFlightsRouter().show(from: window)
        return true
    }
    
}

