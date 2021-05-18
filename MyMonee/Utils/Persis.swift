//
//  Persis.swift
//  MyMonee
//
//  Created by Rizky Saputra on 18/05/21.
//

import Foundation

class PersistData {
    
    enum Key: String, CaseIterable {
            case name, avatarData
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

