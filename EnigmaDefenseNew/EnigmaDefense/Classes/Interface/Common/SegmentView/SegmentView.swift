//
//  SegmentView.swift
//  EnigmaDefense
//
//  Created by Александр on 19.04.2021.
//

import UIKit

class SegmentView: UIView {

    var didVPNTapped: (() -> Void)?
    var didAdBlockTapped: (() -> Void)?
    var didPasswordTapped: (() -> Void)?
    
    private lazy var background: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "segment-background")
        return view
    }()
    private lazy var vpnButton: UIButton = {
        var button = UIButton(type: .custom)
//        button.backgroundColor = .blue
        button.setTitleColor(UIColor(hexString: "#8D8DA6"), for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitle("VPN", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
//        button.setImage(UIImage(named: "vpn"), for: .normal)
//        button.setImage(UIImage(named: "vpn-selected"), for: .selected)
        button.addTarget(self, action: #selector(onDidVPNTapped), for: .touchUpInside)
        return button
    }()
    private lazy var adBlockButton: UIButton = {
        var button = UIButton(type: .custom)
//        button.setImage(UIImage(named: "adblock"), for: .normal)
//        button.setImage(UIImage(named: "adblock-selected"), for: .selected)
        button.setTitleColor(UIColor(hexString: "#8D8DA6"), for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitle("AdBlock", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        button.addTarget(self, action: #selector(onDidAdBlockTapped), for: .touchUpInside)
        return button
    }()
    private lazy var passwordButton: UIButton = {
        var button = UIButton(type: .custom)
//        button.setImage(UIImage(named: "adblock"), for: .normal)
//        button.setImage(UIImage(named: "adblock-selected"), for: .selected)
        button.setTitleColor(UIColor(hexString: "#8D8DA6"), for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitle("Keeper", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        button.addTarget(self, action: #selector(onDidPasswordTapped), for: .touchUpInside)
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
    
    func common() {
        self.addSubview(background)
        self.addSubview(vpnButton)
        self.addSubview(adBlockButton)
        self.addSubview(passwordButton)
        
        background.layout.fillSuperview()
        vpnButton.layout.leftEqualToSuperview()
        vpnButton.layout.topEqualToSuperview()
        vpnButton.layout.bottomEqualToSuperview()
        vpnButton.layout.rightEqualTo(adBlockButton.leftAnchor)
        adBlockButton.layout.rightEqualTo(passwordButton.leftAnchor)
        adBlockButton.layout.topEqualToSuperview()
        adBlockButton.layout.bottomEqualToSuperview()
        vpnButton.layout.widthEqualTo(adBlockButton.widthAnchor)
        passwordButton.layout.rightEqualToSuperview()
        passwordButton.layout.topEqualToSuperview()
        passwordButton.layout.bottomEqualToSuperview()
        passwordButton.layout.widthEqualTo(adBlockButton.widthAnchor)
    }
    
    @objc func onDidVPNTapped() {
        self.setVPNButton()
        self.didVPNTapped?()
    }
    
    @objc func onDidAdBlockTapped() {
        self.setAdBlockButton()
        self.didAdBlockTapped?()
    }
    
    @objc func onDidPasswordTapped() {
        self.setPasswordButton()
        self.didPasswordTapped?()
    }
    
    func setAdBlockButton() {
        self.vpnButton.isSelected = false
        self.adBlockButton.isSelected = true
        self.passwordButton.isSelected = false
    }
    
    func setVPNButton() {
        self.vpnButton.isSelected = true
        self.adBlockButton.isSelected = false
        self.passwordButton.isSelected = false
    }
    
    func setPasswordButton() {
        self.vpnButton.isSelected = false
        self.adBlockButton.isSelected = false
        self.passwordButton.isSelected = true
    }
    
//    private lazy var left
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
