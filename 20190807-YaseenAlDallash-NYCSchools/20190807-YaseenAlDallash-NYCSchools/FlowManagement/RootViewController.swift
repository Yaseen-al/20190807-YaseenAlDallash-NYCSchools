//
//  RootViewController.swift
//  YourBank
//
//  Created by Yaseen Al Dallash on 8/1/19.
//  Copyright © 2019 Yaseen Al Dallash. All rights reserved.
//

import UIKit

//https://medium.com/@stasost/ios-root-controller-navigation-3625eedbbff

class RootViewController: UIViewController {
    
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
        self.addChildViewController(current)
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
