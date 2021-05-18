//
//  UserData.swift
//  MyMonee
//
//  Created by Rizky Saputra on 13/05/21.
//

import Foundation

struct UserData: Codable {
    
    var user: User
    var transactions: [Transaction]
    var dreams: [Dream]
    
    init(user: User, transactions: [Transaction], dreams: [Dream]) {
        self.user = user
        self.transactions = transactions
        self.dreams = dreams
    }
    
    func totalDream() -> Int {
        return dreams.count
    }
    
    func countTotal(type: TransactionType) -> Double {
        var total: Double = 0
        for transaction in self.transactions {
            if transaction.type == type {
                total += transaction.total ?? 0
            }
        }
        
       return total
    }
    
    func countTotalInString(type: TransactionType) -> String {
        let formatter = currencyFormatter()
        return "Rp. \(formatter.string(from: NSNumber(value: countTotal(type: type)))!)"
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
    
    func updateBalance(num: Double, type: TransactionType) {
                
        if type == .income {
            user.balance += num
        }
        else if type == .outcome {
            user.balance -= num
        }
    }
}

var user = User(name: "Rizky Saputra", balance: 0)
var transactions: [Transaction] = []
var dream: [Dream] = []

var userData = getAndDecodeFromLocal() ?? UserData(user: user, transactions: transactions, dreams: dream)
