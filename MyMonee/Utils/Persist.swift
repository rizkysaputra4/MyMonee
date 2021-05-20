//
//  Persis.swift
//  MyMonee
//
//  Created by Rizky Saputra on 18/05/21.
//

import Foundation

class PersistData {
    
    enum Key: String, CaseIterable {
        case name, avatarData, mainData
            func make(for userID: String) -> String {
                return self.rawValue + "_" + userID
            }
    }
    
    var defaults = UserDefaults.standard
    
    init(defaults: UserDefaults = .standard) {
            self.defaults = defaults
    }
    
    func saveValue(forKey key: Key, value: Any, userID: String) {
            defaults.set(value, forKey: key.make(for: userID))
        }
    func readValue<T>(forKey key: Key, userID: String) -> T? {
            return defaults.value(forKey: key.make(for: userID)) as? T
        }

}

func encodeAndSaveToLocal(data: UserData) {
    let jsonEncoder = JSONEncoder()
    guard let jsonData = try? jsonEncoder.encode(data) else {
        return
    }
    let json = String(data: jsonData, encoding: String.Encoding.utf8)
    print(json!)
    PersistData().saveValue(forKey: .mainData, value: json!, userID: "user")
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
