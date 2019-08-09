//
//  FLowManager.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/1/19.
//  Copyright © 2019 Yaseen Al Dallash. All rights reserved.
//

import UIKit


protocol FlowManager: class {
    func route(to newVC: UIViewController, with delay: TimeInterval)
}
