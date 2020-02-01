//
//  AvailableFlightsViewController.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright (c) 2019 Michel. All rights reserved.
//

import UIKit

protocol AvailableFlightsViewProtocol: BaseViewProtocol {
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    func showSections(sections: [SectionsModuleRepresentable])
    func reloadSections(section: Int)
}

protocol AvailableFlightsConfigurableViewProtocol: class {
    
    func set(presenter: AvailableFlightsPresenterProtocol)
    
}

class AvailableFlightsViewController: BaseViewController {
    
    // MARK: - Public properties
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Private properties
    private let elementsDataSource = ElementsDataSource()
    private var presenter:AvailableFlightsPresenterProtocol?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.getTitle()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    private func setupTableView() {
        tableView.dataSource = elementsDataSource
        tableView.delegate = elementsDataSource
        tableView.register(AvailableFlightTableViewCell.self)
        tableView.registerHeader(nib: UINib(nibName: HeaderView.reuseIdentifier,
                                            bundle: nil),
                                 withHeaderFooterViewClass: HeaderView.self)
        tableView.estimatedRowHeight = 90.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

// MARK: - AvailableFlightsViewProtocol

extension AvailableFlightsViewController:  AvailableFlightsViewProtocol {
    
    func showSections(sections: [SectionsModuleRepresentable]) {
        elementsDataSource.setDataSource(elements: sections)
        tableView.reloadData()
    }
    
    func reloadSections(section: Int) {
        tableView.beginUpdates()
        tableView.reloadSections([section], with: .fade)
        tableView.endUpdates()
    }
}

// MARK: - AvailableFlightsViewProtocol

extension AvailableFlightsViewController:  AvailableFlightsConfigurableViewProtocol {
    
    func set(presenter: AvailableFlightsPresenterProtocol) {
        self.presenter = presenter
    }
}
