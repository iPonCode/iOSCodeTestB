//  Array.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 12/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

extension Array where Element == Transaction {

    // Using this extension to filter only elements with valid dates
    
    var onlyDatedTransactions: Transactions {
        return self.filter({ $0.date != nil }).compactMap(
            { Transaction(id: $0.id,
                          date: $0.date, // at this point sure this Date is not nil
                          amount: $0.amount,
                          fee: $0.fee,
                          description: $0.description)
        })
    }

}

extension Array where Element: Hashable {

    func removingDuplicates() -> [Element] {
        
        // Using a updateValue() method in a dictionary because return nil when item is new
        var dictionary = [Element: Bool]()
        return filter { dictionary.updateValue(true, forKey: $0) == nil }
    }
    
    // Array struct instance methods needs mutating to update his values
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
