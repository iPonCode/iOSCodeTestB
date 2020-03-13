//  Sequence.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 13/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
