//
//  PasswordStorage.swift
//  MiSecure
//
//  Created by Александр on 10.05.2021.
//

import UIKit

struct Password: Codable {
    var label: String
    var password: String
    var date: Int
}

class PasswordStorage {

    static let shared = PasswordStorage()
    
    var masterCode: String? {
        let master = UserDefaults.standard.string(forKey: "MasterCode")
        return master
    }
    func getPasswords() -> [Password] {
        if let data = UserDefaults.standard.value(forKey:"Passwords") as? Data {
            if let passwords = try? PropertyListDecoder().decode(Array<Password>.self, from: data) {
                return passwords
            }
        }
        
        return []
    }
    
    func create(password: Password) {
        var passwords = self.getPasswords()
        passwords.append(password)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(passwords), forKey: "Passwords")
        UserDefaults.standard.synchronize()
    }
    
}
