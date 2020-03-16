//  Counters.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 16/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

struct Counters {
    
    var total: Int
    var valid: Int
    var unique: Int
    var filtered: Int
    
    init() {
        
        self.total = 0
        self.valid = 0
        self.unique = 0
        self.filtered = 0
        
        return
    }
}
