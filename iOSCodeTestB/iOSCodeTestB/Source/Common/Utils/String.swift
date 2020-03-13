//  String.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 13/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
