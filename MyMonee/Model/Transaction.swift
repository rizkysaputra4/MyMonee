//
//  UserTransactionHistory.swift
//  MyMonee
//
//  Created by Rizky Saputra on 13/05/21.
//

import Foundation

enum TransactionType: String, Codable {
    case income, outcome
    
}

struct Transaction: Codable {
    
    var uuid: String?
    var description: String?
    var date: Date?
    var total: Double?
    var type: TransactionType?
    
    init(description: String, date: Date, total: Double, type: TransactionType) {
        self.description = description
        self.date = date
        self.total = total
        self.type = type
    }
    
    init() {}
    
}

extension Transaction: DateUtil, CurrencyUtil {
    
    func currencyToString() -> String {
        return currencyFormatter().string(from: NSNumber(value: self.total ?? 0))!
    }
    
    func dateToString() -> String {
        return dateFormated(date: self.date)
    }
}
