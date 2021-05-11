//
//  MenuCell.swift
//  EnigmaDefense
//
//  Created by Александр on 19.04.2021.
//

import UIKit

class MenuCell: UITableViewCell {

    private lazy var iconView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "whis texc"
        label.textColor = Pallete.textColor
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func common() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        
        iconView.layout.widthEqualTo(20)
        iconView.layout.heightEqualTo(20)
        iconView.layout.centerVertically()
        iconView.layout.leftEqualToSuperview(constant: 20)
        
        titleLabel.layout.leftEqualTo(iconView.rightAnchor, constant: 20)
        titleLabel.layout.rightEqualToSuperview(constant: -20)
        titleLabel.layout.topEqualToSuperview()
        titleLabel.layout.bottomEqualToSuperview()
    }
    
    func configure(icon: UIImage, title: String) {
        self.iconView.image = icon
        self.titleLabel.text = title
    }

}
