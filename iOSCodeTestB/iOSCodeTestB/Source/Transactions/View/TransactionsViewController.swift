//  TransactionViewController.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 10/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import UIKit
import Alamofire

class TransactionsViewController: UIViewController {

    static let TransactionCellIdAndNibName = "TransactionCell"
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerTableView: UITableView!
    
    var viewModel: TransactionsViewModel = TransactionsViewModelImpl()
    var transactions: Transactions = Transactions() // this will be binded
    var firstTransaction: Transaction = Transaction()

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: configure view, binding and lauch viewmodel method to webservice
        configureView()
        bindViewModel()
        retrieveTransactions()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // Wait a little bit for async webservice response
//            debugPrint("viewDidload+1.5 - Dump viewController data stored:")
//            dump(self.transactions)
        }
    
    }

    func configureView() {
        
        // TODO: Register cell
        headerTableView.register(UINib(nibName: TransactionsViewController.TransactionCellIdAndNibName, bundle: nil), forCellReuseIdentifier: TransactionsViewController.TransactionCellIdAndNibName)
        
        tableView.register(UINib(nibName: TransactionsViewController.TransactionCellIdAndNibName, bundle: nil), forCellReuseIdentifier: TransactionsViewController.TransactionCellIdAndNibName)
        
        // TODO: Configure searchBar
        
        // TODO: Configure navigation button
        
        title = "Consultando transacciones…"
    }

    func bindViewModel() {
        
        // Start Listening transaction array
        viewModel.transactions.bind({ [weak self] (result) in
            guard let result = result else {
                return
            }
            // This will occur when viewmodel var update itself
            self?.transactions = result
            self?.tableView.reloadData()
            self?.updateTitle()
        })

        // Start Listening first transaction
        viewModel.firstTransaction.bind({ [weak self] (result) in
            guard let result = result else {
                return
            }
            // This will occur when viewmodel var update itself
            self?.firstTransaction = result
            self?.headerTableView.reloadData()
        })
    }

    func retrieveTransactions() {
        viewModel.retrieveTransactions()
    }

    func updateTitle() {
        title = String(format: "%d Transacciones", transactions.count + 1)
    }
    
}

// MARK: - Methods of UITableViewDataSource protocol

extension TransactionsViewController: UITableViewDataSource {

    // tableView (transactions) and headerTableView (firstTransaction)

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72 // provisional value
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            return transactions.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsViewController.TransactionCellIdAndNibName, for: indexPath) as? TransactionCellImpl {
            
            if tableView == self.tableView {
                let transaction = transactions[indexPath.row]
                cell.configure(id: transaction.id,
                               date: transaction.date!, // at this point sure this Date is not nil // ?? Date(),
                               amount: transaction.amount,
                               fee: transaction.fee ?? nil,
                               description: transaction.description ?? nil)

                // TODO: protocol for cell actions, maybe needed to check/unceck certain cell options,
                //       like mark as favourite or similar
                //cell.delegate = self

                // TODO: assign indexPath to cell tag may be necessary to know witch cell was selected
                cell.tag = indexPath.row
                
            } else if tableView == headerTableView {
                
                cell.configure(id: firstTransaction.id,
                               date: firstTransaction.date ?? Date(),
                               amount: firstTransaction.amount,
                               fee: firstTransaction.fee ?? nil,
                               description: firstTransaction.description ?? nil)
                debugPrint("datasource headerTableView - Dump viewController firstTransaction stored:")
                dump(firstTransaction)
            }

            return cell
        }
        
        return UITableViewCell()
    }
    
}

// MARK: - Methods of UITableViewDelegate protocol

extension TransactionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // TODO: push to a detailed view

        // because highlighted color was setted (storyboard) for some label, this effect is wanted
        
    
        // uncomment next line if wanted this effect only while the tableView cells is being pressed
        //tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == headerTableView {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

// MARK: - Methods of UISearchBarDelegate

extension TransactionsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // TODO: call ViewModel method width text to filter data
     }

}
