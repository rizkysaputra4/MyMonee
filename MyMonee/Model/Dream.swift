//
//  UserDream.swift
//  MyMonee
//
//  Created by Rizky Saputra on 13/05/21.
//

import Foundation

class Dream {
    
    var description: String
    var target: Double
    var saved: Double
    
    init(description: String, target: Double, saved: Double) {
        self.description = description
        self.target = target
        self.saved = saved
    }
}
