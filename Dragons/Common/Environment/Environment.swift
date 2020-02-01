//
//  Environment.swift
//  Dragons
//
//  Created by Michel on 29/01/2020.
//  Copyright © 2020 Michel. All rights reserved.
//

import Foundation

struct Environment {
    
    private static let typeFileEnvironment = "plist"
    private static let nameFileEnvironment = "Info"
    private static let isMockKey = "isMock"
    
    private var plistEnvironment : [String: Any] = [:]
    
    // MARK: - Init
    
    private init() {
        if let plist = Bundle.main.infoDictionary {
            plistEnvironment = plist
        }
    }
    
    // MARK: - Shared Instance
    
    static let shared = Environment()
    
    var isMock: Bool {
        return plistEnvironment[Environment.isMockKey] as? Bool ?? false
    }
}

