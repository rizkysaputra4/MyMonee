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
        for transaction in self.transactions where transaction.type == type {
            total += transaction.total ?? 0
        }
        
       return total
    }
    
    func countTotalInString(type: TransactionType) -> String {
        let formatter = currencyFormatter()
        return "Rp. \(formatter.string(from: NSNumber(value: countTotal(type: type)))!)"
    }
    
    func updateBalance(num: Double, type: TransactionType) {
                
        if type == .income {
            user.balance += num
        } else if type == .outcome { user.balance -= num }
    }
    
    func getDreamProgress(dreamIndex: Int) -> Double {
        let progress = self.user.balance / self.dreams[dreamIndex].target
        if progress > 1 {
            return 1
        }
        return progress
    }
    
    func getDreamProgressLabel(dreamIndex: Int) -> String {
        let formatter = currencyFormatter()
        let stringTarget = formatter.string(
            from: NSNumber(value: self.dreams[dreamIndex].target))!
        let stringSaved = formatter.string(
            from: NSNumber(value: self.user.balance))!
        
        return "IDR \(stringSaved) / IDR \(stringTarget)"
    }
    
}

var user = User(name: "Rizky Saputra", balance: 0)
var transactions: [Transaction] = []
var dream: [Dream] = []

var userData = getData() ?? UserData(user: user, transactions: transactions, dreams: dream)
var isLoading = false
