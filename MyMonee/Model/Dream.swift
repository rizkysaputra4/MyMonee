//
//  UserDream.swift
//  MyMonee
//
//  Created by Rizky Saputra on 13/05/21.
//

import Foundation

class Dream: Codable {
    
    var description: String
    var target: Double

    init(description: String, target: Double) {
        self.description = description
        self.target = target
        
    }
    
}

extension Dream: CurrencyUtil {
    func currencyToString() -> String {
        let formatter = currencyFormatter()
        let stringTarget = formatter.string(from: NSNumber(value: self.target))!
        return "Rp. \(stringTarget)"    }
}
