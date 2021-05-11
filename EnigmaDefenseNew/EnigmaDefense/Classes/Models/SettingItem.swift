//
//  SettingItem.swift
//  EnigmaDefense
//
//  Created by Александр on 20.04.2021.
//

import UIKit

class SettingSection {
    var title: String
    var items: [SettingItem]
    
    init(title: String, items: [SettingItem]) {
        self.title = title
        self.items = items
    }
    
}

enum SettingCellType {
    case switchh
    case detail
}

class SettingItem {

    var type: SettingsType
    var cellType: SettingCellType
    
    func getView() -> UIView {
        var view: UIView!
        
        switch cellType {
            case .switchh:
                let switchView = SwitchView()
                switchView.configure(title: type.rawValue, value: SettingsStorageService.bool(of: type))
                view = switchView
                break
            case .detail:
                let detailView = DetailView()
                detailView.configure(title: type.rawValue)
                view = detailView
                break
        }
        
        return view
    }
    
    init(type: SettingsType, cellType: SettingCellType) {
        self.type = type
        self.cellType = cellType
    }
    
    static var settings: [SettingSection] {
        let adblock = SettingItem(type: .turnAdBlock, cellType: .switchh)
        let notification = SettingItem(type: .notifications, cellType: .switchh)
        let wifi = SettingItem(type: .wifiUpdatesOnly, cellType: .switchh)
        let notifymeabout = SettingItem(type: .notifyMeAboutUpdates, cellType: .switchh)
        
        let rate = SettingItem(type: .rateapp, cellType: .detail)
        let term = SettingItem(type: .termOfUse, cellType: .detail)
        let contact = SettingItem(type: .contactSupport, cellType: .detail)
        
        let general = SettingSection(title: "General", items: [adblock, notification, wifi, notifymeabout])
        let info = SettingSection(title: "Info", items: [rate, term, contact])
        
        return [info]
    }
    
    static var filters: [SettingSection] {
        let increase = SettingItem(type: .increaseWebsiteLoadingSpeed, cellType: .switchh)
        let malicious = SettingItem(type: .maliciousAndPhishingAds, cellType: .switchh)
        let annoying = SettingItem(type: .annoyingVideoAds, cellType: .switchh)
        
        let adultContent = SettingItem(type: .adultContent, cellType: .switchh)
        let stopTrackingScripst = SettingItem(type: .stopTrackingScripst, cellType: .switchh)
        
        let safe = SettingItem(type: .safeTrafficWhileRoamingToAvoidExtraHarges, cellType: .switchh)
        let subscriptions = SettingItem(type: .subscriptionToOperatorServices, cellType: .switchh)
        
        let ads = SettingSection(title: "ADS", items: [increase, malicious, annoying])
        let content = SettingSection(title: "Content", items: [adultContent, stopTrackingScripst])
        let more = SettingSection(title: "More", items: [safe, subscriptions])
        
        return [ads, content, more]
    }
    
}
