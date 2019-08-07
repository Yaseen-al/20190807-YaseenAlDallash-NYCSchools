//
//  SplashViewController.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/7/19.
//  Copyright © 2019 Yaseen AlDallash. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    private let logo = UIImageView(image: UIImage(named: ""))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(logo)
        logo.center = view.center
    }

}
