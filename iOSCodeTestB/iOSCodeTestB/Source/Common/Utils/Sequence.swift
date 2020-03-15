//  Sequence.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 13/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

public extension Sequence where Element: Equatable {
    
    var uniqueElements: [Element] {
        return self.reduce(into: []) {
            uniqueElements, element in
            
            if !uniqueElements.contains(element) {
                uniqueElements.append(element)
            }
        }
    }
}
