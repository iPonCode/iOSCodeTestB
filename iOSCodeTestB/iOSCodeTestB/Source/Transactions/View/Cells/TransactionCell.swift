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
    
    @IBOutlet weak var descripitonLabel: UILabel!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stackFee: UIStackView!
    @IBOutlet weak var stackFeeWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var topSeparator: UIView!
    
    // This occurs when the xib is ready
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(id: String) {
        
        // TODO: Set cell fields
        // TODO: Configure logic to hide/show stackFee and update totalView color depending amount sign
        
        descripitonLabel.text = id.isEmpty ? setDefaultDescription() : id

        let randomDouble = Double.random(in: -999.9 ..< 999.0)
        totalLabel.text = String(format: "%.2f", randomDouble)
        
        let randomDoubleA = Double.random(in: -999.9 ..< 999.0)
        amountLabel.text = String(format: "%.2f", randomDoubleA)
        
        let randomDoubleF = Double.random(in: -99.9 ..< -0.01)
        feeLabel.text = String(format: "%.2f", randomDoubleF)
        
        let width:CGFloat = totalView.bounds.width
        totalView.layer.masksToBounds = true
        totalView.layer.cornerRadius = width/3

        feeLabel.layer.masksToBounds = true
        feeLabel.layer.cornerRadius = 4

        totalLabel.layer.masksToBounds = true
        totalLabel.layer.cornerRadius = 6
        totalLabel.backgroundColor = UIColor.bgTotalColor

        Bool.random() ? setIncomeColor() : setExpenseColor()
        
        hasFee(Bool.random())
        
        topSeparator.alpha = 0.15

    }
    
    private func hasFee(_ has: Bool) {
        if has {
            stackFeeWidthConstraint.constant = 0.0
        } else {
            stackFeeWidthConstraint.constant = 100.0
            feeLabel.backgroundColor = UIColor.bgStackFeeColor
        }
        
    }
    
    private func setDefaultDescription() -> String{
        descripitonLabel.alpha = 0.35
        return "Esta transacción no tiene descripción"
    }
    
    
    private func setIncomeColor() {
        totalView.backgroundColor = UIColor.incomeColor
        //topSeparator.backgroundColor = UIColor.incomeColor
    }
    
    private func setExpenseColor() {
        totalView.backgroundColor = UIColor.expenseColor
        //topSeparator.backgroundColor = UIColor.expenseColor
    }
}

extension UIColor {
    static let bgTotalColor = UIColor(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 0.3)
    static let bgStackFeeColor = UIColor(red: 253/255.0, green: 141/255.0, blue: 14/255.0, alpha: 0.25)
    static let expenseColor = UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.35)
    static let incomeColor = UIColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.35)
}
