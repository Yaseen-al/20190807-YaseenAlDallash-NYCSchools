//
//  UIView+Extension.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/7/19.
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
    
    /// Calling this function to load form nib and to cast to `Self`
    ///
    /// Note:
    ///
    /// In Xcode 11 this issue is solved and you can cast directly without doing this work around while the compiler can compile it 
    ///
    ///https://stackoverflow.com/questions/30816139/returning-self-in-swift
    private class func loadAndCast<T>(owner: Any?, nibName: String, bundle: Bundle, options: [UINib.OptionsKey : Any]?) -> T {
        return UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: owner, options: options).first as! T
    }
}


