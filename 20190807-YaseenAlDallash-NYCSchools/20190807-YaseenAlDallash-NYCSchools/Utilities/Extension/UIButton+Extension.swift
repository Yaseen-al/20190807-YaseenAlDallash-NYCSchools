//
//  UIButton+Extension.swift
//  YourBank
//
//  Created by Yaseen Al Dallash on 7/30/19.
//  Copyright © 2019 Yaseen Al Dallash. All rights reserved.
//

import UIKit
extension UIButton {
    
    func setBackGroundColor(color: UIColor, for state: UIControl.State) {
        // Begin Graphics editing
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        // Get currrent context
        guard let currentContext = UIGraphicsGetCurrentContext() else {return}
        currentContext.setFillColor(color.cgColor)
        currentContext.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        // End Graphics update
        UIGraphicsEndImageContext()
        // Set the background color
        setBackgroundImage(colorImage, for: state)
    }
}
