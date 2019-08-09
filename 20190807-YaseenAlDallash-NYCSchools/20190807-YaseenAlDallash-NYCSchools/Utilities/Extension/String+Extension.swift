//
//  String+Extension.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/7/19.
//  Copyright © 2019 Yaseen Al Dallash. All rights reserved.
//

import Foundation
extension String {
    
    func capitalizeFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizeFirstLetter()
    }
}
