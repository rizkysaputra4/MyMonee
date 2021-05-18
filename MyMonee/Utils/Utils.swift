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

func getLocalTimeNow() -> String {
    let now = Date()

    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.dateFormat = "yyyy-MM-dd - HH:mm"
    let dateString = formatter.string(from: now)
    return dateString
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

func encodeAndSaveToLocal(data: UserData) {
    let jsonEncoder = JSONEncoder()
    guard let jsonData = try? jsonEncoder.encode(data) else {
        return
    }
    let json = String(data: jsonData, encoding: String.Encoding.utf8)
    PersistData().saveValue(forKey: .mainData , value: json!, userID: "user")
}

func getAndDecodeFromLocal() -> UserData? {
    
    let dataParsed: String? = PersistData().readValue(forKey: .mainData, userID: "user")
    
    guard let stringUserData = dataParsed else {
        print("nil when parsing user data from storage")
        return nil
    }
    
    let jsonDecoder = JSONDecoder()
   
    guard  let dataConverted = try? jsonDecoder.decode(UserData.self, from: stringUserData.data(using: .utf8)!) else {
        print("error when convert data string to object")
        return nil
    }
    
    return dataConverted
}

