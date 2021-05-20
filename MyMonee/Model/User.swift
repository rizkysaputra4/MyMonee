//
//  UserData.swift
//  MyMonee
//
//  Created by Rizky Saputra on 12/05/21.
//

import Foundation

class User: Codable {
    
    var name: String
    var balance: Double
    var photoLink: String?
    
    init(name: String, balance: Double) {
        self.name = name
        self.balance = balance
    }
    
}

extension User: CurrencyUtil {
    func currencyToString() -> String {
        return "Rp. \(currencyFormatter().string(from: NSNumber(value: self.balance))!)"
    }
}
