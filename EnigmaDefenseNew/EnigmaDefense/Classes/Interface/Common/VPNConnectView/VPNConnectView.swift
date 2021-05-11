//
//  VPNConnectView.swift
//  EnigmaDefense
//
//  Created by Александр on 21.04.2021.
//

import UIKit

class VPNConnectView: NibView {

    var didCountryTapped: (() -> Void)?
    
    static let topBackground = UIColor(hexString: "#15141C").withAlphaComponent(0.5)
    static let bottomBackground = UIColor(hexString: "#1A191F")
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            VPNConnectView.topBackground.cgColor,
            VPNConnectView.bottomBackground.cgColor
        ]
        gradient.locations = [0, 1]
        return gradient
    }()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryLogoView: UIImageView!
    @IBOutlet weak var connectionView: UIImageView!
    @IBOutlet weak var connectionLabel: UILabel!
    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var downloadLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        common()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        common()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.removeFromSuperlayer()
        gradient.frame = self.bounds
        containerView.layer.insertSublayer(gradient, at: 0)
    }
    
    func common() {
        
        gradient.cornerRadius = 32
        gradient.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDidCountryViewTapped))
        countryView.addGestureRecognizer(tapRecognizer)
    }
    
    func configure(country: VPNCountry?, isConnection: Bool? = nil) {
        if let country = country {
            self.countryLogoView.image = UIImage(named: country.country.rawValue)
            self.countryLabel.text = country.country.rawValue
        } else {
            self.countryLogoView.image = nil
            self.countryLabel.text = "Loading"
        }
        if let isConnection = isConnection {
            self.connectionLabel.text = isConnection ? "Not Connecting" : "Connected"
            self.connectionView.image = isConnection ? UIImage(named: "connection") : UIImage(named: "not-connection")
        }
    }
    
    func setDownloadSpeed(string: String) {
        self.downloadLabel.text = string
    }
    
//    func configure(country: VPNCountry?) {
//        if let country = country {
//            self.countryLogoView.image = UIImage(named: country.country.rawValue)
//            self.countryLabel.text = country.country.rawValue
//        } else {
//            self.countryLogoView.image = nil
//            self.countryLabel.text = "Loading"
//        }
//    }
    func configure(isConnecting: Bool, status: String, upload: String, download: String) {
        self.connectionLabel.text = status
        self.uploadLabel.text = upload
        self.downloadLabel.text = download
        self.connectionLabel.text = isConnecting ? "Connected" : "Not Connecting"
        self.connectionView.image = isConnecting ? UIImage(named: "connection") : UIImage(named: "not-connection")
    }
    
    @objc func onDidCountryViewTapped() {
        self.didCountryTapped?()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
