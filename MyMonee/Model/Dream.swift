//
//  UserDream.swift
//  MyMonee
//
//  Created by Rizky Saputra on 13/05/21.
//

import Foundation

class Dream: CurrencyFormat {
    
    var description: String
    var target: Double
    var saved: Double
    
    init(description: String, target: Double, saved: Double) {
        self.description = description
        self.target = target
        self.saved = saved
    }
    
    func currencyToString() -> String {
        let formatter = currencyFormatter()
        let stringTarget = formatter.string(from: NSNumber(value: self.target))!
        let stringSaved = formatter.string(from: NSNumber(value: self.saved))!
        
        return "IDR \(stringSaved) / IDR \(stringTarget)"
    }
    
    func getStringTarget() -> String {
        let formatter = currencyFormatter()
        let stringTarget = formatter.string(from: NSNumber(value: self.target))!
        return "Rp. \(stringTarget)"
    }
    
    func currencyFormatter() -> NumberFormatter {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.decimalSeparator = ","
        currencyFormatter.groupingSeparator = "."
        currencyFormatter.groupingSize = 3
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.maximumFractionDigits = 2
        return currencyFormatter
    }
    
    func getDreamProgress() -> Double {
        let progress = self.saved / self.target
        if progress > 1 {
            return 1
        }
        return progress
    }
}
   
