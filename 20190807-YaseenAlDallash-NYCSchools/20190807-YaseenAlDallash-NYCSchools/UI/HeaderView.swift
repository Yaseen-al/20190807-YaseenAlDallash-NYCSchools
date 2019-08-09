//
//  HeaderView.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/4/19.
//  Copyright © 2019 Yaseen Al Dallash. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    var contentViewEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero
    override var alignmentRectInsets: UIEdgeInsets {
        return contentViewEdgeInsets
    }
    
    @IBOutlet weak var contentStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContentStackView()
    }
    
    
    func setupContentStackView() {
        contentStackView.axis = .vertical
        contentStackView.spacing = 10
        contentStackView.distribution = .fillProportionally
        contentStackView.alignment = .center
    }
    
    func addTitle(text: String,
                  font: UIFont = .custom(name: .regular, size: 18)) {
        let label = UILabel()
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.tag = contentStackView.arrangedSubviews.count
        contentStackView.addArrangedSubview(label)
    }
    
    func add(_ view: UIView) {
        view.tag = contentStackView.arrangedSubviews.count
        contentStackView.addArrangedSubview(view)
    }
}
