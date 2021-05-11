//
//  VPNButtonView.swift
//  EnigmaDefense
//
//  Created by Александр on 21.04.2021.
//

import UIKit

class VPNButtonView: NibView {

    @IBOutlet weak var buttonLogoView: UIImageView!
    var timer: Timer?
    
    func setConnectionStatus(isActive: Bool) {
        let image = isActive ? "VPNButtonOff" : "VPNButtonOn"
        self.buttonLogoView.image = UIImage.init(named: image)!
    }
    
    func connecting() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onDidTimerTicked), userInfo: nil, repeats: true)
    }
    
    func stopConnecting() {
        self.timer?.invalidate()
    }
    
    @objc func onDidTimerTicked() {
        UIView.animate(withDuration: 0.3) {
            self.buttonLogoView.alpha = 0.5
            UIView.animate(withDuration: 0.3) {
                self.buttonLogoView.alpha = 1
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
