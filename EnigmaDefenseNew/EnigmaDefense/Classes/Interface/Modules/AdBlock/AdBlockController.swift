//
//  AdBlockController.swift
//  EnigmaDefense
//
//  Created by Александр on 19.04.2021.
//

import UIKit
import NetworkExtension

class AdBlockController: CommonViewController {

    private lazy var adBlockButton: UIButton = {
        var button = UIButton.init(type: .custom)
        button.layout.widthEqualTo(80)
        button.layout.heightEqualTo(80)
        button.addTarget(self, action: #selector(onDidVPNConnectTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "adblock-on"), for: .normal)
        return button
    }()
    private lazy var timeLabel: UILabel = {
        var label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "00:00:05"
        label.isHidden = true
        return label
    }()
    private lazy var stateLabel: UILabel = {
        var label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = Pallete.textColor.withAlphaComponent(0.6)
        label.textAlignment = .center
        label.text = "Activated"
        return label
    }()
    private lazy var shieldIconView: UIImageView = {
        var iconView = UIImageView()
        iconView.layout.heightEqualTo(85)
        return iconView
    }()
    private lazy var shieldView: UIView = {
        var view = UIView()
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(stateLabel)
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(shieldIconView)
        stackView.layout.widthEqualTo(80)
        
        view.addSubview(stackView)
        stackView.layout.topEqualToSuperview()
        stackView.layout.bottomEqualToSuperview()
        stackView.layout.centerHorizontally()
        return view
    }()
    
    @objc func onDidBecomeActive() {
        refreshBlocker()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(shieldView)
        self.view.addSubview(adBlockButton)
        AdBlockService.shared.reloadBlockContent()
        _ = VPNManager.shared
        
        vpnStateChanged(status: VPNManager.shared.status)
        VPNManager.shared.statusEvent.attach(self, AdBlockController.vpnStateChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshBlocker()
        loadConfigure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let topAreaHeight = (self.view.frame.height * 0.411530815)
        let spacingY = ((topAreaHeight - 45) - 130) / 2 + 10

        let centerY = self.view.frame.height - topAreaHeight
        shieldView.constraints.forEach({ shieldView.removeConstraint($0) })
        adBlockButton.constraints.forEach({ adBlockButton.removeConstraint($0) })
        shieldView.layout.widthEqualTo(80)
        shieldView.layout.heightEqualTo(130)
        shieldView.layout.bottomEqualTo(self.view.topAnchor, constant: topAreaHeight - spacingY)
        shieldView.layout.centerHorizontally()
        
        adBlockButton.layout.topEqualTo(self.view.topAnchor, constant: topAreaHeight + spacingY)
        adBlockButton.layout.centerHorizontally()
        adBlockButton.layout.widthEqualTo(80)
        adBlockButton.layout.heightEqualTo(80)
    }
    
    func refreshBlocker() {
        AdBlockService.shared.handleBlockerState { (isActive) in
            DispatchQueue.main.async {
                isActive ? self.stateActive() : self.stateDeactive()
            }
        }
        
        if VPNManager.shared.isDisconnected {
            self.adBlockButton.setImage(UIImage(named: "adblock-on"), for: .normal)
        } else {
            self.adBlockButton.setImage(UIImage(named: "adblock-off"), for: .normal)
        }
    }
    
    func vpnStateChanged(status: NEVPNStatus) {
//        changeControlEnabled(state: VPNManager.shared.isDisconnected)
        switch status {
            case .disconnected, .invalid, .reasserting:
                self.adBlockButton.alpha = 1
                self.adBlockButton.setImage(UIImage(named: "adblock-on"), for: .normal)
            case .connected:
                self.adBlockButton.alpha = 1
                self.adBlockButton.setImage(UIImage(named: "adblock-off"), for: .normal)
            case .connecting:
                self.adBlockButton.alpha = 0.5
            case .disconnecting:
                self.adBlockButton.alpha = 0.5
                break
            @unknown default: break
        }
    }
    
    @objc func onDidVPNConnectTapped() {
        if VPNManager.shared.isDisconnected {
            if let cCountry = currentCountry {
                let config = Configuration(server: cCountry.serverID, account: cCountry.username, password: cCountry.password, onDemand: false, psk: cCountry.psk)
                VPNManager.shared.connectIKEv2(config: config) { (success) in
                    self.adBlockButton.setImage(UIImage(named: "adblock-off"), for: .normal)
                } onError: { (error) in
                    let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            VPNManager.shared.disconnect {
                self.adBlockButton.setImage(UIImage(named: "adblock-off"), for: .normal)
            }
        }
    }
    
    private func stateActive() {
        self.shieldIconView.image = UIImage(named: "shield-on")
        self.stateLabel.text = "Activated"
    }

    private func stateDeactive() {
        self.shieldIconView.image = UIImage(named: "shield-off")
        self.stateLabel.text = "Not active"
    }

    func loadConfigure() {
        refreshBlocker()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
