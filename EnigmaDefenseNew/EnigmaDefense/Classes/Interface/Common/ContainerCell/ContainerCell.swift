//
//  ContainerCell.swift
//  EnigmaDefense
//
//  Created by Александр on 19.04.2021.
//

import UIKit

class ContainerCell: UITableViewCell {

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
    private lazy var containerView: UIView = {
        var view = UIView.init()
//        view.backgroundColor = .blue
        return view
    }()
    private lazy var stackView: UIStackView = {
        var view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.backgroundColor = .cyan
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        gradient.frame = containerView.bounds
//        containerView.layer.addSublayer(gradient)
    }
    
    override func draw(_ rect: CGRect) {
//        gradient.frame = containerView.bounds
//        containerView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func common() {
        self.selectionStyle = .none
//        contentView.backgroundColor = .red
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        containerView.layout.fillSuperview(inset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
//        stackView.layout.fillSuperview(inset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: -20))
    }
    
    func configure(views: [UIView]) {
        self.stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        views.forEach { (v) in
            v.backgroundColor = .brown
            stackView.addArrangedSubview(v)
        }
        self.setNeedsLayout()
    }

}
