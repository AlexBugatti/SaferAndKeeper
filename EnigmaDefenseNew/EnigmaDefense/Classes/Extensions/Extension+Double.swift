//
//  Extension+Double.swift
//  EnigmaDefense
//
//  Created by Александр on 30.04.2021.
//

import Foundation
import UIKit

extension Double {
    
    func toString() -> String {
        let formatter = NumberFormatter.init()
        formatter.maximumFractionDigits = 2
        let string = formatter.string(from: NSNumber(value: self))
        return string ?? ""
    }
    
}
