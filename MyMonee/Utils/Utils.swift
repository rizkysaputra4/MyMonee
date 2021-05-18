//
//  Utils.swift
//  MyMonee
//
//  Created by Rizky Saputra on 18/05/21.
//

import Foundation

func getCurrentDateAndTime() -> String {
    let currentDateTime = Date()

    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    formatter.dateStyle = .long

    return formatter.string(from: currentDateTime)
}

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