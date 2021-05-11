//
//  DetailView.swift
//  EnigmaDefense
//
//  Created by Александр on 21.04.2021.
//

import UIKit

class DetailView: UIView {

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Simple Text"
        return label
    }()
    private lazy var detailView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "detail")
        view.layout.heightEqualTo(20)
        view.layout.widthEqualTo(20)
        return view
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 300, height: 36))
        setup()
    }
    
    private func setup() {
        self.addSubview(titleLabel)
        self.addSubview(detailView)

        titleLabel.layout.leftEqualToSuperview()
        titleLabel.layout.topEqualToSuperview()
        titleLabel.layout.bottomEqualToSuperview()
        titleLabel.layout.rightEqualTo(detailView.leftAnchor, constant: -20)
//
//        switchView.layout.heightEqualTo(24)
        detailView.layout.rightEqualToSuperview(constant: -12)
        detailView.layout.centerVertically()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
