//
//  Utils.swift
//  MyMonee
//
//  Created by Rizky Saputra on 18/05/21.
//

import Foundation

func toStringCurrency(number: Double) -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.decimalSeparator = ","
    currencyFormatter.groupingSeparator = "."
    currencyFormatter.groupingSize = 3
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.maximumFractionDigits = 2
    
    return "Rp. \(currencyFormatter.string(from: NSNumber(value: number))!)"
}

func currentTime() -> String {
    let hour = Calendar.current.component(.hour, from: Date())
    let isMorning = hour >= 3 && hour < 11
    let isNoon = hour >= 11 && hour < 15
    let isAfternoon = hour >= 15 && hour < 19
    let isNight = hour >= 19 && hour < 3
    
    if isMorning {
        return "Pagi"
    }
    
    if isNoon {
        return "Siang"
    }
    
    if isAfternoon {
        return "Sore"
    }
    
    if isNight {
        return "Malam"
    }
    
    return "Pagi"
}

func dateFormated(date: Date?) -> String {
    
    guard let thisDate = date else {
        return "--"
    }
    
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.dateFormat = "yyyy-MM-dd - HH:mm"
    let dateString = formatter.string(from: thisDate)
    return dateString
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

func randomString(length: Int) -> String {
    let letters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    var randomString: String = ""
    for _ in 0..<length {
        let randomNumber = Int.random(in: 0..<letters.count)
        randomString.append(letters[randomNumber])
    }
    return randomString
}
