//
//  AvailableFlightsRouter.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright (c) 2019 Michel. All rights reserved.
//

import UIKit

class AvailableFlightsRouter {
    
    // MARK: - Public variables
    
    // MARK: - Private variables
    
    private var view:AvailableFlightsViewController {
        
        let controller = AvailableFlightsViewController(nibName: "AvailableFlights", bundle: nil)
        let presenter: AvailableFlightsPresenterProtocol = AvailableFlightsPresenter(view: controller, dataManager: dataManager)
        controller.set(presenter: presenter)
        return controller
    }
    
    private var dataManager: AvailableFlightsDataManagerProtocol {
        return AvailableFlightsDataManager(apiClient: apiClient,
                                           storageManager: storageManager)
    }
    
    private var apiClient: AvailableFlightsApiClientProtocol {
        if Environment.shared.isMock { return AvailableFlightsApiClientMock()}
               
        return AvailableFlightsApiClient()
    }
    private var storageManager: GOTStorageProtocol {
        return GOTStorageManager()
    }
    
    // MARK: - Initialization
    
    init() {}
    
    func show(from windwow: UIWindow?) {
        let navigationController = UINavigationController(rootViewController: view)
        windwow?.rootViewController = navigationController
        windwow?.makeKeyAndVisible()
    }
}

