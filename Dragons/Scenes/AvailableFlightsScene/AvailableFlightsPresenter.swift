//
//  AvailableFlightsPresenter.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright (c) 2019 Michel. All rights reserved.
//

import UIKit

protocol AvailableFlightsPresenterProtocol: class {
    /**
     * Add here your methods for communication VIEW -> PRESENTER
     */
    func viewDidLoad()
    func getTitle()
    func handleAvailableFlights(availableFlightsResponse: AvailableFlightsResponse)
    func getAvailableFlightsViewModel(flightValues: [String : [AvailableFlightResponse]], exchangeValue: [ExchangeModel]) -> [SectionsModuleRepresentable]
}

class AvailableFlightsPresenter {
    
    // MARK: - Public variables
    
    var view:AvailableFlightsViewProtocol?
    
    // MARK: - Private variables
    
    private var dataManager: AvailableFlightsDataManagerProtocol
    private var price: Double?
    private var values: [AvailableFlightDetailRepresentable]?
    
    // MARK: - Initialization
    
    init(view:AvailableFlightsViewProtocol,
         dataManager: AvailableFlightsDataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    // MARK: - Private methods
    private func saveCurrencies(currencies: Set<String>) {
        dataManager.saveCurrencies(currencies: Array(currencies))
    }
    
    private func saveCurrencyDate(){
        dataManager.saveCurrencydate()
    }
}

extension AvailableFlightsPresenter: AvailableFlightsPresenterProtocol {
    
    func viewDidLoad() {
        dataManager.getAvailableFlights { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let availableFlightsResponse):
                
                guard let availableFlightsResponse = availableFlightsResponse else {
                    self.view?.showCustomAlert(options: ErrorRenderingOptions(title: "ERROR_TITLE".localized,
                                                                              message: "ERROR_RETRIEVING_FLIGHTS".localized))
                    return
                }
                let currencies = Set(availableFlightsResponse.results.map{$0.currency})
                self.saveCurrencies(currencies: currencies)
                self.saveCurrencyDate()
                self.handleAvailableFlights(availableFlightsResponse: availableFlightsResponse)
                
            case .failure(let error):
                self.view?.showDefaultAlert(options: ErrorRenderingOptions(title: "ERROR_TITLE".localized, message: error.errorDescription))
                break
            }
        }
    }
    
    func getTitle() {
        view?.showTitle(title: dataManager.getTitle())
    }
    
    func handleAvailableFlights(availableFlightsResponse: AvailableFlightsResponse) {
        
        dataManager.getAvailableCurrencies { [weak self] result in
            guard let self = self else {return}
            self.view?.showLoading()
            
            switch result {
            case .success(let exchangeValue):
                self.view?.hideLoading()
                let availableFlightsViewModel = self.getAvailableFlightsViewModel(flightValues: Dictionary(grouping: availableFlightsResponse.results) { $0.inbound.originAndDestination}, exchangeValue: exchangeValue)
                self.view?.showSections(sections: availableFlightsViewModel)
                self.dataManager.setSections(sections: availableFlightsViewModel)
                
            case .failure(let error):
                self.view?.showDefaultAlert(options: ErrorRenderingOptions(title: "ERROR_TITLE".localized,
                                                                           message: error.localizedDescription))
            }
        }
    }
    
    func getAvailableFlightsViewModel(flightValues: [String : [AvailableFlightResponse]], exchangeValue: [ExchangeModel]) -> [SectionsModuleRepresentable] {
        
        var sections = [SectionsModuleRepresentable]()
        for originAndDestination in flightValues.keys {
            
            
            flightValues[originAndDestination]?.forEach{ element in
                if let price = exchangeValue.first(where: {$0.toCurrencyValue == Constants.Currency.eur && $0.fromCurrencyValue == element.currency}) {
                    self.price = element.price * price.exchangeRate
                    values = flightValues[originAndDestination]?.map{$0.getAvailableFlightDetail(price: self.price ?? 0.0)}
                }}
            
            let section = AvailableFlightsSection(sectionElement: AvailableFlightsSectionViewModel(elements: values,
                                                                                                   delegate: self,
                                                                                                   section: SectionTitleViewModel(title: originAndDestination,price: self.price ?? 0.0)))
            sections.append(section)
        }
        
        return sections.sorted { $0.sectionElement.section.price < $1.sectionElement.section.price}
    }
}

extension AvailableFlightsPresenter: HeaderViewDelegate {
    
    func toggleSection(header: HeaderView, section: Int) {
        
        guard let itemSection = dataManager.getSections()else {return}
        var sectionElement = itemSection[section].sectionElement
        if sectionElement.isCollapsible {
            sectionElement.isCollapsed = !sectionElement.isCollapsed
            header.setCollapsed(collapsed: !sectionElement.isCollapsed)
            view?.reloadSections(section: section)
        }
    }
}
