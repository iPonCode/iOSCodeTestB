//  Array.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 12/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

extension Array where Element == Transaction {

    // Using this extension to filter only elements with valid dates
    
    var transactionsWithDate: [Transaction] {
        return self.filter({ $0.date != nil }).compactMap(
            { Transaction(id: $0.id,
                          date: $0.date, // at this point sure this Date is not nil
                          amount: $0.amount,
                          fee: $0.fee,
                          description: $0.description)
        })
    }

}
