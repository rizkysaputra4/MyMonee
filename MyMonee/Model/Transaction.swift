//
//  UserTransactionHistory.swift
//  MyMonee
//
//  Created by Rizky Saputra on 13/05/21.
//

import Foundation

enum TransactionType:String, Codable {
    case income, outcome
    
}

struct Transaction: Codable {
    
    var uuid: String?
    var description: String?
    var date: String?
    var total: Double?
    var type: TransactionType?
    
    init(description: String, date: String, total: Double, type: TransactionType) {
        self.description = description
        self.date = date
        self.total = total
        self.type = type
    }
    
    init() {}
    
    func getCurrencyString(number: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.decimalSeparator = ","
        currencyFormatter.groupingSeparator = "."
        currencyFormatter.groupingSize = 3
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.maximumFractionDigits = 2
        
        return currencyFormatter.string(from: NSNumber(value: number))!
    }
    
    func transactionLabel() -> String {
        return "Rp. \(getCurrencyString(number: self.total ?? 0))"
    }

}
