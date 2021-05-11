//
//  MenuItem.swift
//  EnigmaDefense
//
//  Created by Александр on 19.04.2021.
//

import UIKit

class MenuItem {
    
    enum MenuItemType: String {
        case filters = "Filters"
        case settings = "Settings"
        case rateus = "Rate Us"
        case contact = "Contact Support"
        case term = "Terms of use"
        case privacy = "Privacy Policy"
    }
    
    var icon: UIImage
    var type: MenuItemType
    
    init(icon: UIImage, type: MenuItemType) {
        self.icon = icon
        self.type = type
    }
    
    static var items: [MenuItem] = {
        var filter = MenuItem(icon: UIImage(named: "filters")!, type: .filters)
        var settings = MenuItem(icon: UIImage(named: "settings")!, type: .settings)
        let rateUs = MenuItem(icon: UIImage(named: "rate")!, type: .rateus)
        let contact = MenuItem(icon: UIImage(named: "contact")!, type: .contact)
        let terms = MenuItem(icon: UIImage(named: "term")!, type: .term)
        
        return [settings, rateUs, contact, terms]
    }()
    
}
