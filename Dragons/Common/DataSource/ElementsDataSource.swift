//
//  ElementsDataSource.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import UIKit

class ElementsDataSource: NSObject {
    
    var elements: [SectionsModuleRepresentable]?
    
    func setDataSource(elements: [SectionsModuleRepresentable]) {
        self.elements = elements
    }
}

extension ElementsDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return elements?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let item = elements?[section] else {return 0}
        if item.sectionElement.isCollapsed && item.sectionElement.isCollapsible {
            return 0
        }
        return item.sectionElement.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let element = elements?[indexPath.section].sectionElement.elements?[indexPath.row] else {return UITableViewCell()}
         let cell = tableView.dequeueReusableCell(forIndexPath: indexPath, type: element.cellType)
        if let configurableCell = cell as? ConfigurableModuledModel {
            configurableCell.configure(element: element)
        }
        
        return cell
    }
}

extension ElementsDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         
         guard let sectionElement = elements?[section].sectionElement,
             let headerView = tableView.dequeueReusableHeaderFooterView(withClass: sectionElement.headerView)
         else { return UIView() }
         if let configurableHeaderView = headerView as? ConfigurableSectionModuledModel {
            configurableHeaderView.configure(element: sectionElement, section: section)
         }
      
         return headerView
     }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
}
