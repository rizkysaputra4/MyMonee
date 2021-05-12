//
//  UserData.swift
//  MyMonee
//
//  Created by Rizky Saputra on 12/05/21.
//

import Foundation

class User {
    
    var name: String
    var balance: Double
    
    init(name: String, balance: Double) {
        self.name = name
        self.balance = balance
    }
    
    func currencyFormat() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.decimalSeparator = ","
        currencyFormatter.groupingSeparator = "."
        currencyFormatter.groupingSize = 3
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.maximumFractionDigits = 2
        
        return currencyFormatter.string(from: NSNumber(value: self.balance))!
    }
}

var user = User(name: "Rizky Saputra", balance: 1000000)
