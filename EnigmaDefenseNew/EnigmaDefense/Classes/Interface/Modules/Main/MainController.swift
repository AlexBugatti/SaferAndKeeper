//
//  MainController.swift
//  EnigmaDefense
//
//  Created by Александр on 19.04.2021.
//

import UIKit
import SideMenu

class MainController: ViewController {

    private lazy var headerView: UIView = {
        var view = UIView()
        view.addSubview(menuButton)
        menuButton.layout.leftEqualToSuperview()
        menuButton.layout.centerVertically()
        
        let textAtrribute = NSMutableAttributedString(string: "VPN and", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.white])
        let adAtrribute = NSAttributedString(string: " Adblocker", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white])
        textAtrribute.append(adAtrribute)
        let label = UILabel.init()
        label.attributedText = textAtrribute
        
//        let logo = UIImageView(image: UIImage(named: "EnigmaDefense"))
        view.addSubview(label)
//        logo.contentMode = .scaleAspectFit
        label.layout.widthEqualTo(200)
        label.layout.heightEqualTo(28)
        label.layout.centerSuperview()
        
        return view
    }()
    private lazy var segmentView: SegmentView = {
        var view = SegmentView()
        view.layout.heightEqualTo(44)
        view.layout.widthEqualTo(300)
        return view
    }()
    private lazy var menuButton: UIButton = {
        var button = UIButton(type: .custom)
        button.layout.heightEqualTo(32)
        button.layout.widthEqualTo(32)
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.addTarget(self, action: #selector(onDidMenuTapped), for: .touchUpInside)
        return button
    }()
    private lazy var adBlockController: AdBlockController = {
        var vc = AdBlockController(nibName: nil, bundle: nil)
        return vc
    }()
    private lazy var vpnController: VPNController = {
        var vc = VPNController(nibName: nil, bundle: nil)
        vc.view.isHidden = true
        return vc
    }()
    private lazy var passwordController: PasswordsViewController = {
        var vc = PasswordsViewController(nibName: nil, bundle: nil)
        vc.view.isHidden = true
        return vc
    }()
    private lazy var containerView: UIView = {
        var view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        self.view.addSubview(headerView)
        self.view.addSubview(containerView)
        self.view.addSubview(segmentView)
        headerView.layout.leftEqualToSuperview(constant: 20)
        headerView.layout.topEqualTo(self.view.safeAreaLayoutGuide.topAnchor, constant: 28)
        headerView.layout.rightEqualToSuperview(constant: -20)
        headerView.layout.heightEqualTo(64)
        
        segmentView.layout.topEqualTo(headerView.bottomAnchor)
        segmentView.layout.centerHorizontally()
        
        containerView.layout.leftEqualToSuperview()
        containerView.layout.rightEqualToSuperview()
        containerView.layout.bottomEqualTo(self.view.bottomAnchor)
        containerView.layout.topEqualTo(segmentView.topAnchor)
        setupControllers()
        segmentView.setAdBlockButton()
        segmentView.didVPNTapped = {
//            self.vpnController.loadConfigure()
            self.adBlockController.view.isHidden = true
            self.vpnController.view.isHidden = false
            self.passwordController.view.isHidden = true
        }
        segmentView.didAdBlockTapped = {
            self.adBlockController.loadConfigure()
            self.adBlockController.view.isHidden = false
            self.vpnController.view.isHidden = true
            self.passwordController.view.isHidden = true
        }
        segmentView.didPasswordTapped = {
            self.adBlockController.view.isHidden = true
            self.vpnController.view.isHidden = true
            self.passwordController.view.isHidden = false
        }
        // Do any additional setup after loading the view.
    }
    
    func loadConfigure() {
        
    }
    
    func setupControllers() {
        self.addChild(adBlockController)
        self.addChild(vpnController)
        self.addChild(passwordController)
        containerView.addSubview(adBlockController.view)
        containerView.addSubview(vpnController.view)
        containerView.addSubview(passwordController.view)
        
        adBlockController.didMove(toParent: self)
        vpnController.didMove(toParent: self)
        passwordController.didMove(toParent: self)
        
        adBlockController.view.layout.fillSuperview()
        vpnController.view.layout.fillSuperview()
        passwordController.view.layout.fillSuperview()
    }
    
    @objc func onDidMenuTapped() {
//        let menuVC = MenuController(nibName: nil, bundle: nil)
//        let sideMenu = SideMenuNavigationController(rootViewController: menuVC)
//        sideMenu
        self.present(SideMenuManager.default.leftMenuNavigationController ?? UIViewController(), animated: true, completion: nil)
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
