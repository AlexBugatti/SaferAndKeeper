//
//  SwitchView.swift
//  EnigmaDefense
//
//  Created by Александр on 19.04.2021.
//

import UIKit

class SwitchView: UIView {

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Simple Text"
        return label
    }()
    private lazy var switchView: UISwitch = {
        var view = UISwitch()
//        view.layout.heightEqualTo(24)
        view.layout.widthEqualTo(40)
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        self.addSubview(titleLabel)
        self.addSubview(switchView)

        titleLabel.layout.leftEqualToSuperview()
        titleLabel.layout.topEqualToSuperview()
        titleLabel.layout.bottomEqualToSuperview()
        titleLabel.layout.rightEqualTo(switchView.leftAnchor, constant: -20)
//
//        switchView.layout.heightEqualTo(24)
        switchView.layout.rightEqualToSuperview(constant: -12)
        switchView.layout.centerVertically()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, value: Bool) {
        self.titleLabel.text = title
        self.switchView.setOn(value, animated: false)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
