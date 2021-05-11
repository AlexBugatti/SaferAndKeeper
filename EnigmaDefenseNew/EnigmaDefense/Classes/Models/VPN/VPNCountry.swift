//
//  VPNCountry.swift
//  EnigmaDefense
//
//  Created by Александр on 21.04.2021.
//

import UIKit

class VPNCountry {

    enum Country: String {
        case usa = "USA"
        case uk = "UK"
        case france = "France"
        case germany = "Germany"
        case nkorea = "North Korea"
    }
    
//    var title: String
//    var icon: UIImage
    var country: Country
    var isFavorite: Bool {
        get { UserDefaults.standard.bool(forKey: "\(country.rawValue)coutry") }
        set {   UserDefaults.standard.setValue(newValue, forKey: "\(country.rawValue)coutry")
                UserDefaults.standard.synchronize()
        }
    }
    var serverID: String
    var username: String
    var psk: String
    var password: String
    
    init(country: Country, serverID: String, username: String, psk: String, password: String) {
        self.country = country
        self.serverID = serverID
        self.username = username
        self.psk = psk
        self.password = password
    }
    
    class func coutries() -> [VPNCountry] {
        
        let usa = VPNCountry(country: .usa, serverID: "3.142.212.26", username: "vpnuser", psk: "zBZUB6cTEAhseWFq3Lq5", password: "YeeYKSE4VD5pKthn")
        let uk = VPNCountry(country: .uk, serverID: "3.10.117.72", username: "vpnuser", psk: "aUNEdRKgYMsS8J7mnHzk", password: "anVWV9c3tMsvcqEx")
        let france = VPNCountry(country: .france, serverID: "15.188.23.51", username: "vpnuser", psk: "FnZBXte5qGupB7AKCNGj", password: "hSPW46LPCT4CiwFc")
        let germany = VPNCountry(country: .germany, serverID: "3.66.18.134", username: "vpnuser", psk: "VHa6whjgX5G42qJ9kDhY", password: "irAKGLtMwYXMK3Ti")
        let nKorea = VPNCountry(country: .nkorea, serverID: "3.34.191.169", username: "vpnuser", psk: "kN7reUVFXSjdcx6Fi2KA", password: "UvYYXPPFv9CprFU5")
        
        return [usa, uk, france, germany, nKorea]
    }
    
}
