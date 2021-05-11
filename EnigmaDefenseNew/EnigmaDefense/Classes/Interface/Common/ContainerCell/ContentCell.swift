//
//  ContentCell.swift
//  EnigmaDefense
//
//  Created by Александр on 20.04.2021.
//

import UIKit

class ContentCell: UITableViewCell {

    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.cornerRadius = 10
        gradient.masksToBounds = true
        gradient.colors = [
            Pallete.topSettingCellBackground.cgColor,
            Pallete.bottomSettingCellBackground.cgColor
        ]
        gradient.locations = [0, 1]
        return gradient
    }()
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        gradient.frame = containerView.bounds
        containerView.layer.insertSublayer(gradient, at: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(views: [UIView]) {
        self.stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        views.forEach { (v) in
            stackView.addArrangedSubview(v)
        }
        self.setNeedsLayout()
    }
    
}
