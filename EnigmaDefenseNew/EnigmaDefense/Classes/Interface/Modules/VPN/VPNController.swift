//
//  VPNController.swift
//  EnigmaDefense
//
//  Created by Александр on 19.04.2021.
//

import UIKit
import NetworkExtension

class VPNController: CommonViewController {

    @IBOutlet weak var connectView: VPNConnectView!
    @IBOutlet weak var vpnButtonView: VPNButtonView!
    
    override var currentCountry: VPNCountry? {
        didSet {
            self.connectView?.configure(country: currentCountry)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentCountry = VPNCountry.coutries().first
        connectView.didCountryTapped = {
            self.showCountryPopup()
        }
        
        _ = VPNManager.shared
        vpnStateChanged(status: VPNManager.shared.status)
        VPNManager.shared.statusEvent.attach(self, VPNController.vpnStateChanged)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDidVPNConnectTapped))
        self.vpnButtonView.addGestureRecognizer(tapRecognizer)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        loadConfigure()
    }
    
    @objc func onDidVPNConnectTapped() {
        if VPNManager.shared.isDisconnected {
            connect()
        } else {
            VPNManager.shared.disconnect()
        }
    }
    
    private func connect() {
        if let cCountry = currentCountry {
            let config = Configuration.init(server: cCountry.serverID, account: cCountry.username, password: cCountry.password, onDemand: false, psk: cCountry.psk)
            self.vpnButtonView.connecting()
            VPNManager.shared.connectIKEv2(config: config) { (success) in
            } onError: { (error) in
                let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func showCountryPopup() {
        let popup = CountriesBottomPopupController()
        popup.didCountryTapped = { country in
            self.currentCountry = country
            if VPNManager.shared.isDisconnected == false {
                VPNManager.shared.disconnect {
                    self.connect()
                }
            }
            popup.dismiss(animated: true, completion: nil)
        }
        self.present(popup, animated: true, completion: nil)
    }
    
    func getSpeed() {
        SpeedService().checkForSpeedTest { (downloadSpeed) in
            DispatchQueue.main.async {
                if let speed = downloadSpeed {
                    self.connectView.downloadLabel.text = "\(speed.toString()) MB/s"
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                        let upload = Double.random(in: 0...30) / 100
                        var uploadSpeed = speed - upload
                        uploadSpeed = uploadSpeed < 0 ? 0 : uploadSpeed
                        self.connectView.uploadLabel.text = "\(uploadSpeed.toString()) MB/s"
                    }
                } else {
                    self.connectView.downloadLabel.text = "-"
                }
            }
        }
    }
    
    func vpnStateChanged(status: NEVPNStatus) {
        switch status {
            case .disconnected, .invalid, .reasserting:
                self.connectView.configure(isConnecting: false, status: "Not Connected", upload: "0 KB/s", download: "0 KB/s")
                self.vpnButtonView.setConnectionStatus(isActive: false)
                self.vpnButtonView.stopConnecting()
            case .connected:
                self.connectView.configure(isConnecting: true, status: "Connect", upload: "-", download: "-")
                self.vpnButtonView.setConnectionStatus(isActive: true)
                self.vpnButtonView.stopConnecting()
                self.getSpeed()
            case .connecting:
                self.connectView.configure(isConnecting: false, status: "Connecting...", upload: "0 KB/s", download: "0 KB/s")
            case .disconnecting:
                self.connectView.configure(isConnecting: false, status: "Disconnecting...", upload: "0 KB/s", download: "0 KB/s")
                break
            @unknown default: break
        }
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
