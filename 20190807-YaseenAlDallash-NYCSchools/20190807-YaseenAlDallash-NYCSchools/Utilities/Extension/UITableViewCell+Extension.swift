//
//  UITableViewCell+Extension.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/7/19.
//  Copyright © 2019 Yaseen Al Dallash. All rights reserved.
//

import UIKit
extension UITableViewCell {
    
    class func dequeue(from tableView: UITableView,
                       with indexPath: IndexPath,
                       with Identifier: String? = nil) -> Self {
        let identifier = Identifier ?? className
        return dequeueAndCast(from: tableView, with: indexPath, with: identifier)
    }
    
    private class func dequeueAndCast<T>(from tableView: UITableView,
                                         with indexPath: IndexPath,
                                         with Identifier: String) -> T {
        return tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as! T
    }
    
    class func register(to tableView: UITableView,
                        forCellReuseIdentifier: String? = nil) {
        let reuseIdentifier = forCellReuseIdentifier ?? className
        let nib = UINib.init(nibName: className, bundle: Bundle(for: self))
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
}
