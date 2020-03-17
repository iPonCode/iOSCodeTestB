//  TransactionCell.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 11/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import UIKit

protocol TransactionCell {
    func configure(isHeader: Bool, id: Int, date: Date, amount: Double, fee: Double?, description: String?)
}

class TransactionCellImpl: UITableViewCell, TransactionCell {
    
    @IBOutlet weak var descripitonLabel: UILabel!
    @IBOutlet weak var euroView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stackFee: UIStackView!
    @IBOutlet weak var leftSeparator: UIView!
    @IBOutlet weak var leftSeparatorConstraint: NSLayoutConstraint!
    @IBOutlet weak var lastLabel: UILabel!
    
    // This occurs when the xib is ready
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(isHeader: Bool, id: Int, date: Date, amount: Double, fee: Double?, description: String?) {
        
        if isHeader {
            self.backgroundColor = .tertiarySystemGroupedBackground
            leftSeparatorConstraint.constant = 2.0
            leftSeparator.backgroundColor = .borderCell
            lastLabel.backgroundColor = .backgroundLast
        } else {
            contentView.layer.masksToBounds = true
            contentView.layer.cornerRadius = 8
            lastLabel.isHidden = true
        }
        
        euroView.layer.masksToBounds = true
        euroView.layer.cornerRadius = 10

        lastLabel.layer.masksToBounds = true
        lastLabel.layer.cornerRadius = 4

        feeLabel.layer.masksToBounds = true
        feeLabel.layer.cornerRadius = 4

        totalLabel.layer.masksToBounds = true
        totalLabel.layer.cornerRadius = 8
        totalLabel.backgroundColor = .backgroundTotal

        fee != nil ? hasFee(true) : hasFee(false)
        amount < 0.0 ? setExpenseColor(isHeader) : setIncomeColor(isHeader)
        
        // Set cell info
        dateLabel.text = setDate(date)
        amountLabel.text = String(amount)
        feeLabel.text = String(fee ?? 0.0)
        totalLabel.text = String(format:"%.2f", amount + (fee ?? 0.0))
        descripitonLabel.text = setDescription(description)
        
    }
    
    private func hasFee(_ has: Bool) {
        
        if has {
            stackFee.isHidden = false
            feeLabel.backgroundColor = UIColor.backgroundFee
        } else {
            stackFee.isHidden = true
        }
    }
    
    private func setDate(_ date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES")//.current
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date).capitalizingFirstLetter()

    }
    
    private func setDescription(_ text: String?) -> String {
        
        if let description = text {
            if !description.isEmpty {
                descripitonLabel.textColor = .label
                descripitonLabel.alpha = 1.0
                return description
            } else {
                descripitonLabel.textColor = .secondaryLabel
                descripitonLabel.alpha = 0.5
                return "Descripción vacía"
            }
        } else {
            descripitonLabel.textColor = .secondaryLabel
            descripitonLabel.alpha = 0.5
            return "No hay descripción"
        }
    }
    
    private func setIncomeColor(_ isHeader: Bool) {
        
        euroView.backgroundColor = UIColor.distinctiveIncome
        if !isHeader{
            leftSeparator.backgroundColor = .distinctiveIncome
            contentView.backgroundColor = .backgroundCellIncome
        }
    }
    
    private func setExpenseColor(_ isHeader: Bool) {
        
        euroView.backgroundColor = UIColor.distinctiveExpense
        if !isHeader {
            leftSeparator.backgroundColor = .distinctiveExpense
            contentView.backgroundColor = .backgroundCellExpense
        }
    }
    
}
