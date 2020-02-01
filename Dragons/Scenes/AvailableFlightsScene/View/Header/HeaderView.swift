//
//  HeaderView.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: class {
    func toggleSection(header: HeaderView, section: Int)
}

protocol ConfigurableSectionModuledModel {
    func configure(element: ModuledSectionModelProtocol, section: Int)
}

class HeaderView: UITableViewHeaderFooterView, ConfigurableSectionModuledModel {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var section: Int = 0
    
    private weak var delegate: HeaderViewDelegate?
        
    override func awakeFromNib() {
       super.awakeFromNib()
       addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
       contentView.backgroundColor = .white
       
    }

    // MARK: - ConfigurableSectionModuledModel
    
    func configure(element: ModuledSectionModelProtocol, section: Int) {
        titleLabel.configure(textConfigurable: TextStyles.flightHeaderPrice(text: element.section.title))
        priceLabel.configure(textConfigurable: TextStyles.flightHeaderPrice(text: "from "  + "\(String(format: "%.2f", element.section.price)) " + Currency.EUR.description))
        setCollapsed(collapsed: element.isCollapsed)
        delegate = element.delegate
        self.section = section
    }
  
     func setCollapsed(collapsed: Bool) {
       arrowLabel.rotate(collapsed ? 0.0 : .pi)
    }
    
    // MARK: - Private methods
    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self,
                                section: section)
    }
}
