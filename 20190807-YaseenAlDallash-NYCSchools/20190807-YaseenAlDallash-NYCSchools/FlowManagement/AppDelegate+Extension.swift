//
//  AppDelegate+Extension.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/1/19.
//  Copyright © 2019 Yaseen Al Dallash. All rights reserved.
//

import UIKit

extension AppDelegate {
    static var shared: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            Logger.log("Can't get shared delegate", eventType: .severe)
            fatalError()
        }
        return delegate
    }
    
    var rootViewController: RootViewController {
        guard let controller = window?.rootViewController as? RootViewController else {
            Logger.log("Can't load root View controller", eventType: .severe)
            fatalError()
        }
        return controller
    }
}
