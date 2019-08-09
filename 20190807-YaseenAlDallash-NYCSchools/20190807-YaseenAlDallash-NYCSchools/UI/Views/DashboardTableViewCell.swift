//
//  DashboardTableViewCell.swift
//  20190807-YaseenAlDallash-NYCSchools
//
//  Created by Yaseen Al Dallash on 8/8/19.
//  Copyright © 2019 Yaseen Al Dallash. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sideImage: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var containerStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        sideImage.image = nil
        subtitleLabel.text = nil
        bodyLabel.text = nil
    }
    
    
    func configure(titleText: String,
                   subtitleText: String,
                   sideImage: UIImage?,
                   bodyLabelText: String) {
        titleLabel.text = titleText
        titleLabel.font = UIFont.custom(name: .regular, size: 18)
        self.sideImage.image = sideImage
        subtitleLabel.text = subtitleText
        subtitleLabel.font = UIFont.custom(name: .regular, size: 16)
        bodyLabel.text = bodyLabelText
        bodyLabel.font = UIFont.custom(name: .regular, size: 14)
    }
    
    func configureUI() {
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = UIColor(hex: "F5F6F7").cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
