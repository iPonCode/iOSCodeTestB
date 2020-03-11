//  TransactionCell.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 11/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import UIKit

protocol TransactionCell {
    func configure() // TODO: Pass field values
}

class TransactionCellImpl: UITableViewCell, TransactionCell {
    
    // This occurs when the xib is ready
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        // TODO: Set cell fields
    }
}
