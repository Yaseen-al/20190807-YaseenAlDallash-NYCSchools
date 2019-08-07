//
//  RootViewController.swift
//  YourBank
//
//  Created by Yaseen Al Dallash on 8/1/19.
//  Copyright © 2019 Yaseen Al Dallash. All rights reserved.
//

import UIKit

//https://medium.com/@stasost/ios-root-controller-navigation-3625eedbbff

/// Handles routing the flow and switching window's root viewcontroller by changing the `RootViewController`'s child.
class RootViewController: UIViewController, FlowManager {
    
    private var current: UIViewController
    
    init() {
        self.current = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addChildViewController(current)
        // For Demonestration it will launch `DashBoardViewController` but can add a login controller and then authenticate then route to
        // Proper flow.
        route(to: DashBoardViewController(), with: 3.0)
    }
    
    func setupUI() {
        view.backgroundColor = .white
    }
    
    func route(to newVC: UIViewController, with delay: TimeInterval = 0.0){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.addChildViewController(newVC)
            self?.current.view.removeFromSuperview()
            self?.current.removeFromParent()
            self?.current = newVC
        }
    }
}
