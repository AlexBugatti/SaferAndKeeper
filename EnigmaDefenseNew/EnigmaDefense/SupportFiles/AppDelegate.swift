//
//  AppDelegate.swift
//  EnigmaDefense
//
//  Created by Александр on 19.04.2021.
//

import UIKit
import SideMenu

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        _ = VPNManager.shared
        let mainVC = MainController()
        let navController = UINavigationController(rootViewController: mainVC)
        navController.setNavigationBarHidden(true, animated: true)
        self.window?.rootViewController = navController
        
        let customTransition: SideMenuPresentationStyle = {
            let sm = SideMenuPresentationStyle.init()
            sm.presentingTranslateFactor = 1
            sm.menuScaleFactor = 0.75
            sm.menuOnTop = false
            return sm
        }()
        
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: MenuController(nibName: nil, bundle: nil))
        leftMenuNavigationController.presentationStyle = customTransition
        leftMenuNavigationController.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        
        UISwitch.appearance().onTintColor = Pallete.accentColor
        
        let bool = SettingsStorageService.bool(of: .turnAdBlock)
        print(bool)
        
        return true
    }

}

