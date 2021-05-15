//
//  UserData.swift
//  MyMonee
//
//  Created by Rizky Saputra on 12/05/21.
//

import Foundation

class User: CurrencyFormat {
    
    var name: String
    var balance: Double
    
    init(name: String, balance: Double) {
        self.name = name
        self.balance = balance
    }
    
    func currencyToString() -> String {
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
