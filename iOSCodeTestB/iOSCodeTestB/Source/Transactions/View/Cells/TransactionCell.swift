//  TransactionCell.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 11/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import UIKit

protocol TransactionCell {
    func configure(id: String) // TODO: Pass field values
}

class TransactionCellImpl: UITableViewCell, TransactionCell {
    
    @IBOutlet weak var label: UILabel!
    // This occurs when the xib is ready
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(id: String) {
        // TODO: Set cell fields
        label.text = id
    }
}
