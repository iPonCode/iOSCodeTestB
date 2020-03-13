//  TransactionCell.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 11/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import UIKit

protocol TransactionCell {
    func configure(id: Int, date: Date, amount: Double, fee: Double?, description: String?)
}

class TransactionCellImpl: UITableViewCell, TransactionCell {
    
    @IBOutlet weak var descripitonLabel: UILabel!
    @IBOutlet weak var euroView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stackFee: UIStackView!
    @IBOutlet weak var stackFeeWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftSeparator: UIView!
    
    // This occurs when the xib is ready
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(id: Int, date: Date, amount: Double, fee: Double?, description: String?) {
        
        // TODO: Configure logic to hide/show stackFee and update totalView color depending amount sign
        
        let width:CGFloat = euroView.bounds.width
        euroView.layer.masksToBounds = true
        euroView.layer.cornerRadius = width/3

        feeLabel.layer.masksToBounds = true
        feeLabel.layer.cornerRadius = 4

        totalLabel.layer.masksToBounds = true
        totalLabel.layer.cornerRadius = 6
        totalLabel.backgroundColor = UIColor.bgTotalColor

        fee != nil ? hasFee(true) : hasFee(false)
        amount < 0.0 ? setExpenseColor() : setIncomeColor()
        
        // Set cell info
        dateLabel.text = setDate(date)
        amountLabel.text = String(amount)
        feeLabel.text = String(fee ?? 0.0)
        totalLabel.text = String(format:"%.2f", amount + (fee ?? 0.0))
        
        descripitonLabel.text = setDescription(description)
        
    }
    
    private func hasFee(_ has: Bool) {
        if has {
            stackFeeWidthConstraint.constant = 100.0
            feeLabel.backgroundColor = UIColor.bgStackFeeColor
        } else {
            stackFeeWidthConstraint.constant = 0.0
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
    
    private func setIncomeColor() {
        euroView.backgroundColor = UIColor.incomeColor
        leftSeparator.backgroundColor = UIColor.incomeColor
    }
    
    private func setExpenseColor() {
        euroView.backgroundColor = UIColor.expenseColor
        leftSeparator.backgroundColor = UIColor.expenseColor
    }
    
}
