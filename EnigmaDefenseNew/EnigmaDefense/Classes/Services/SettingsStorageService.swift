//
//  SettingsStorageService.swift
//  EnigmaDefense
//
//  Created by Александр on 20.04.2021.
//

import UIKit

enum SettingsType: String {
    case turnAdBlock = "Turn On AdBlock when VPN start's"
    case notifications = "Notifications"
    case wifiUpdatesOnly = "Wi-Fi updates only"
    case notifyMeAboutUpdates = "Notify me about updates"
    
    case rateapp = "Rate app"
    case termOfUse = "Term of use"
    case contactSupport = "Contact support"
    
    //ADS
    case increaseWebsiteLoadingSpeed = "Increase website loading speed"
    case maliciousAndPhishingAds = "Malicious and phishing ads"
    case annoyingVideoAds = "Annoing video ads"

    //Content
    case adultContent = "Adult content"
    case stopTrackingScripst = "Stop tracking scripst"
    
    //More
    case safeTrafficWhileRoamingToAvoidExtraHarges = "Safe Traffic While Roaming To Avoid Extra Harges"
    case subscriptionToOperatorServices = "Subscription To Operator Services"
}

class SettingsStorageService: NSObject {
    
    static var defaults: [SettingsType: Bool] = [SettingsType.turnAdBlock: false,
                                                 SettingsType.notifications: false,
                                                 SettingsType.wifiUpdatesOnly: true,
                                                 SettingsType.notifyMeAboutUpdates: false,
                                                 SettingsType.increaseWebsiteLoadingSpeed: false,
                                                 SettingsType.maliciousAndPhishingAds: true,
                                                 SettingsType.annoyingVideoAds: true,
                                                 SettingsType.adultContent: false,
                                                 SettingsType.stopTrackingScripst: false,
                                                 SettingsType.safeTrafficWhileRoamingToAvoidExtraHarges: true,
                                                 SettingsType.subscriptionToOperatorServices: true
    ]

    static func bool(of type: SettingsType) -> Bool {
        if let object = UserDefaults.standard.value(forKey: type.rawValue) as? Bool {
            return object
        } else {
            return SettingsStorageService.defaults[type] ?? false
        }
    }
    
    static func set(type: SettingsType, value: Bool) {
        UserDefaults.standard.setValue(value, forKey: type.rawValue)
        UserDefaults.standard.synchronize()
    }
    
}
