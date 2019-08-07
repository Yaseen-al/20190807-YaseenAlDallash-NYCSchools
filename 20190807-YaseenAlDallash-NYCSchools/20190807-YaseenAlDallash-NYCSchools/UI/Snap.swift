//
//  Snap.swift
//  YourBank
//
//  Created by Yaseen Al Dallash on 8/4/19.
//  Copyright © 2019 Yaseen Al Dallash. All rights reserved.
//

import UIKit

enum Snap {
    static func fill(view: UIView, in parentView: UIView, with offset: UIEdgeInsets = .zero) {
        parentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: offset.top),
            view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: offset.bottom),
            view.rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: offset.right),
            view.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: offset.left)])
    }
}
