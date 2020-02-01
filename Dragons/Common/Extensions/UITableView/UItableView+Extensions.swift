//
//  UItableView+Extensions.swift
//  Dragons
//
//  Created by Michel on 18/01/2020.
//  Copyright © 2019 Michel. All rights reserved.
//

import Foundation
import UIKit

 protocol Reusable {}

 extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib? {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}

extension UITableView {
    
    func register<T: UITableViewCell>(_ :T.Type) {
        register(UINib(nibName: T.reuseIdentifier, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell(forIndexPath indexPath: IndexPath, type: UITableViewCell.Type) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath)
        object_setClass(cell, type)
        return cell
    }
    
     func registerHeader<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
             register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
         }
          
          func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T? {
              guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
                  return nil
              }
              return headerFooterView
          }
}

