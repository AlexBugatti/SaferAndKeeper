//
//  NavigationBar.swift
//  EnigmaDefense
//
//  Created by Александр on 20.04.2021.
//

import UIKit

class NavigationBar: UIView {

    var didBackTapped: (() -> Void)?
    
    private lazy var containerView: UIView = {
        var view = UIView()
        return view
    }()
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Title"
        return label
    }()
    private lazy var backButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back-arrow"), for: .normal)
        button.layout.widthEqualTo(20)
        button.layout.heightEqualTo(20)
        button.addTarget(self, action: #selector(onDidBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        common()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        common()
    }
    
    private func common() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(backButton)
        containerView.layout.fillSuperview(inset: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        titleLabel.layout.fillSuperview(inset: UIEdgeInsets(top: 4, left: 40, bottom: 4, right: 40))
        backButton.layout.leftEqualToSuperview()
        backButton.layout.centerVertically()
    }
    
    func set(title: String) {
        self.titleLabel.text = title
    }
    
    // MARK: - Actions
    
    @objc func onDidBackButtonTapped() {
        self.didBackTapped?()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
