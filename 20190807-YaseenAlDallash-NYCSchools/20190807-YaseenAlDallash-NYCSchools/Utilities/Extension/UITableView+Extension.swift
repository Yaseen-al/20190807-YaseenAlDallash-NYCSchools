//
//  UITableView+Extension.swift
//  YourBank
//
//  Created by Yaseen Al Dallash on 8/7/19.
//  Copyright © 2019 Yaseen Al Dallash. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Dynacically size tableView footer with layout fitting compressed size
    func dynamicallySizeFooter() {
        guard let footer = tableFooterView else { return }
        let size = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        guard footer.frame.size.height != size.height else {return}
        footer.frame.size = size
        tableFooterView = footer
        layoutIfNeeded()
    }
    
    /// Dynacically size tableView header with layout fitting compressed size
    func dynamicallySizeHeader() {
        guard let header = tableHeaderView else { return }
        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        guard header.frame.size.height != size.height else {return}
        header.frame.size = size
        tableHeaderView = header
        layoutIfNeeded()
    }
}
