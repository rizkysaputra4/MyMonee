//
//  UserData.swift
//  MyMonee
//
//  Created by Rizky Saputra on 13/05/21.
//

import Foundation

class UserData {
    
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
}

var user = User(name: "Rizky Saputra", balance: 5000000)

var transactions = [
    Transaction(description: "gaji", date: "2020-01-01", total: 30000, type: .income),
    Transaction(description: "beli mouse", date: "2021-02-01", total: 5000, type: .outcome)
]

var dream = [
    Dream(description: "beli hp", target: 1000000, saved: 1000),
    Dream(description: "beli rumah", target: 2000000, saved: 3000000)
]

var userData = UserData(user: user, transactions: transactions, dreams: dream)
