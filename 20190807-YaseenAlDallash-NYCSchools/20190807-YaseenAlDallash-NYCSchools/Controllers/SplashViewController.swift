//
//  SplashViewController.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/7/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    private var logo: UILabel = {
        let label = UILabel()
        label.text = "NYC Schools"
        label.font = .custom(name: .semiBold, size: 24)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupLogo()
    }
    
    func setupLogo() {
        view.addSubview(logo)
        Snap.fill(view: logo, in: view, with: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
    }

}
