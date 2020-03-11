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
    
    var viewModel: TransactionsViewModel = TransactionsViewModelImpl()
    // TODO: var with binded array data, also pending make model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: configure view, binding and lauch viewmodel method to webservice
        configureView()
        retrieveTransactions()
    }
    
    func configureView() {
        
        // TODO: Register cell
        tableView.register(UINib(nibName: TransactionsViewController.TransactionCellIdAndNibName, bundle: nil), forCellReuseIdentifier: TransactionsViewController.TransactionCellIdAndNibName)
        
        // TODO: Configure searchBar
        
        // TODO: Configure navigation button
        
        title = "Consultando transacciones.."
    }
    
    func retrieveTransactions() {
        viewModel.retrieveTransactions()
    }

}

// MARK: - Methods of UITableViewDataSource protocol

extension TransactionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72 // provisional value
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15 // provisional value, this will be count of data array (binded)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsViewController.TransactionCellIdAndNibName, for: indexPath) as? TransactionCellImpl {
            
            // TODO: load info in data array at indexPath.row and configure cell
            cell.configure()
            
            // TODO: protocol for cell actions, maybe needed to check/unceck certain cell options,
            //       like mark as favourite or similar
            //cell.delegate = self

            // TODO: asign indexPath to cell tag will be necessary to know witch cell was selected
            cell.tag = indexPath.row
            
            return cell
        }
        
        return UITableViewCell()
    }

}

// MARK: - Methods of UITableViewDelegate protocol

extension TransactionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: push to a detailed view
        //tableView.deselectRow(at: indexPath, animated: true)
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
