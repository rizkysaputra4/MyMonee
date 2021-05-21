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
    
    func encodeToJson() -> Data? {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            print("error when encoding data")
            return nil
        }
        
        let stringJson = String(data: jsonData, encoding: .utf8)
        
        return stringJson?.data(using: .utf8, allowLossyConversion: false)!
    }
    
}

extension Transaction: DateUtil, CurrencyUtil {
    
    func currencyToString() -> String {
        return currencyFormatter().string(from: NSNumber(value: self.total ?? 0))!
    }
    
    func dateToString() -> String {
        return dateFormated(date: self.date)
    }
}
