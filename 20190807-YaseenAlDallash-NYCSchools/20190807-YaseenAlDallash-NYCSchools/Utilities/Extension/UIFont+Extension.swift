//
//  UIFont+Extension.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/7/19.
//  Copyright © 2019 Yaseen Al Dallash. All rights reserved.
//

import UIKit

enum CustomFontName: String {
    case bold           = "SFUIText-Bold"
    case boldItalic     = "SFUIText-BoldItalic"
    case heavy          = "SFUIText-Heavy"
    case heavyItalic    = "SFUIText-HeavyItalic"
    case light          = "SFUIText-Light"
    case lightItalic    = "SFUIText-LightItalic"
    case medium         = "SFUIText-Medium"
    case mediumItalic   = "SFUIText-MediumItalic"
    case regular        = "SFUIText-Regular"
    case regularItalic  = "SFUIText-RegularItalic"
    case semiBold       = "SFUIText-Semibold"
    case semiBoldItalic = "SFUIText-SemiboldItalic"
}


extension UIFont {
    
    class func custom(name: CustomFontName, size: CGFloat) -> UIFont {
        let fontDiscreption = UIFontDescriptor(name: name.rawValue, size: size)
        return UIFont(descriptor: fontDiscreption, size: size)
    }
}
