//
//  UIViewController+Extension.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/7/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import UIKit
extension UIViewController {
    
    public func addChildViewController(_ viewController: UIViewController,
                                       frame: CGRect? = nil) {
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        viewController.didMove(toParent: self)
        
        guard let frame = frame else { return }
        viewController.view.frame = frame
    }
    
}
