//
//  UIView+Extension.swift
//  YourBank
//
//  Created by Yaseen Al Dallash on 7/28/19.
//  Copyright © 2019 Yaseen Al Dallash. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Returns string representation of view
   class var className: String {
        return String(describing: self)
    }
    
    /// Loads a view from a nib.
    ///
    /// NibName and View name must match.
    ///  - Parameters:
    ///      - owner: Nib owner.
    ///      - options: Nib options.
    class func loadFromNib(with owner: Any? = nil, _ options: [UINib.OptionsKey : Any]? = nil) -> Self {
        let bundle = Bundle(for: self)
        let nibName = String(describing: self)
        return loadAndCast(owner: owner, nibName: nibName, bundle: bundle, options: options)
    }
    
    private class func loadAndCast<T>(owner: Any?, nibName: String, bundle: Bundle, options: [UINib.OptionsKey : Any]?) -> T {
        return UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: owner, options: options).first as! T
    }
}


