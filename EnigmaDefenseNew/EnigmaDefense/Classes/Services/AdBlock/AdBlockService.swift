//
//  AdBlockService.swift
//  EnigmaDefense
//
//  Created by Александр on 23.04.2021.
//

import UIKit
import SafariServices

class AdBlockService: NSObject {

    static let shared = AdBlockService()
    
    func reloadBlockContent() {
        SFContentBlockerManager.reloadContentBlocker(withIdentifier: Constants.adBlockExtensionIdentifier) { (error) in
            print(error)
        }
    }
    
    func handleBlockerState(completion: @escaping ((Bool) -> Void)) {
        SFContentBlockerManager.getStateOfContentBlocker(withIdentifier: Constants.adBlockExtensionIdentifier) { (state, error) in
            if let _ = error {
                completion(false)
                return
            }
            
            if let state = state {
                completion(state.isEnabled)
            }
        }
    }
    
}
