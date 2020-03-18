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
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var showSearchBarInfoConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomHeaderSeparator: UIView!
    @IBOutlet weak var leftSeparator: UIView!
    @IBOutlet weak var searchBarInfoLabel: UILabel!
    
    var viewModel: TransactionsViewModel = TransactionsViewModelImpl()
    var transactions: Transactions = Transactions() // this will be binded
    var firstTransaction: Transaction = Transaction()
    var counters: Counters = Counters()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        bindViewModel()
        retrieveTransactions()
        
        // Wait a little bit for async webservice response
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            debugPrint("viewDidload+1.5 - Dump viewController data stored:")
//            dump(self.transactions)
//        }
    
    }

    func configureView() {
        
        // Set default title, before call webservice
        title = "Consultando transactiones …"
        
        // Configure navigationBar
        let navBarAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemOrange,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)
        ]
        navigationController?.navigationBar.titleTextAttributes = navBarAttributes
        
        let serverButton = UIBarButtonItem(image: #imageLiteral(resourceName: "endPointB"), style: .plain, target: self, action: #selector(serverButtonTapped))
        navigationItem.setLeftBarButton(serverButton, animated: true)
        
        bottomHeaderSeparator.backgroundColor = .borderCell
        leftSeparator.backgroundColor = .borderCell
        
        // Register cells
        headerTableView.register(UINib(nibName: TransactionsViewController.TransactionCellIdAndNibName, bundle: nil), forCellReuseIdentifier: TransactionsViewController.TransactionCellIdAndNibName)
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .singleLine
        
        tableView.register(UINib(nibName: TransactionsViewController.TransactionCellIdAndNibName, bundle: nil), forCellReuseIdentifier: TransactionsViewController.TransactionCellIdAndNibName)
        headerTableView.backgroundColor = .tertiarySystemGroupedBackground
        headerTableView.isScrollEnabled = false
        headerTableView.separatorStyle = .none
        
        
        // Configure searchBar
        searchBar.barStyle = .default
        searchBar.showsCancelButton = true
        showSearchBar()
        
        // Wait a little bit to let user itself be aware that there are a searchBar
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.hideSearchBar()
        }
        
        searchBarInfoLabel.isUserInteractionEnabled = true
        let tapInsideSearchBarInfo = UITapGestureRecognizer(target: self, action: #selector(showSearchBar))
        searchBarInfoLabel.addGestureRecognizer(tapInsideSearchBarInfo)
        searchBarInfoLabel.backgroundColor = .tertiarySystemGroupedBackground
        
        navigationController?.navigationBar.backgroundColor = .tertiarySystemGroupedBackground
        navigationController?.navigationBar.barStyle = .default
        view.backgroundColor = .tertiarySystemGroupedBackground
        self.view.backgroundColor = tableView.backgroundColor
        
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
            self?.firstTransaction = result
            self?.headerTableView.reloadData()
        })

        // Start Listening counters
        viewModel.counters.bind({ [weak self] (result) in
            guard let result = result else {
                return
            }
            self?.counters = result
            self?.updateInfoSearchBar()
        })

    }

    func retrieveTransactions() {
        viewModel.retrieveTransactions()
    }

    func updateTitle() {
        var endPointName = ""
        switch viewModel.getCurrentEndPoint() {
            case .serverA:
                navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "endPointB")
                endPointName = "A"
            case .serverB:
                navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "endPointA")
                endPointName = "B"
        }
        title = String(format: "Mostrando %d transacciones (%@)", transactions.count + 1, endPointName)
    }
    
    func updateInfoSearchBar() {

        searchBarInfoLabel.text = String(format: "%d total recibidos | %d válidos | %d únicos", counters.total, counters.valid, counters.unique)
        
        let infoLabelText = searchBarInfoLabel.text ?? ""
        if let txt = searchBar.searchTextField.text, !txt.isEmpty {
            searchBarInfoLabel.text = infoLabelText + String(format: "\n< Aplicando filtro: \"%@\" > con %d resultados", txt, counters.filtered)
        } else {
            searchBarInfoLabel.text = infoLabelText + "\n< No hay filtros definidos > Filtrar por descripción"
        }

    }

    @objc func serverButtonTapped() {
        
        title = "Actualizando transactiones …"
        
        clearTables() // (only for visual effect)
        
        // Change endPoint (and reload, aplying filters, etc..)
        switch viewModel.getCurrentEndPoint() {
            
            case .serverA:
                viewModel.setCurrentEndPoint(.serverB)

            case .serverB:
                viewModel.setCurrentEndPoint(.serverA)
        }
    }
    
    fileprivate func clearTables() {
        firstTransaction = Transaction()
        headerTableView.reloadData()
        transactions = []
        tableView.reloadData()
    }
    
}

// MARK: - Methods of UITableViewDataSource protocol

extension TransactionsViewController: UITableViewDataSource {

    // tableView (transactions) and headerTableView (firstTransaction)

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
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
                cell.configure(isHeader: false,
                               id: transaction.id,
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
                
                cell.configure(isHeader: true,
                               id: firstTransaction.id,
                               date: firstTransaction.date ?? Date(),
                               amount: firstTransaction.amount,
                               fee: firstTransaction.fee ?? nil,
                               description: firstTransaction.description ?? nil)
            }

            return cell
        }
        
        return UITableViewCell()
    }
    
    @objc func showSearchBar() {
        searchBarHeightConstraint.constant = 56.0
        showSearchBarInfoConstraint.constant = 0.0
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func hideSearchBar() {
        searchBarHeightConstraint.constant = 0.0
        showSearchBarInfoConstraint.constant = 56.0
        UIView.animate(withDuration: 0.35) {
            self.view.layoutIfNeeded()
        }
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - Methods of UITableViewDelegate protocol

extension TransactionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // TODO: push to a detailed view
        searchBar.resignFirstResponder()

        // Because highlighted color was setted (storyboard) for some label, this effect is wanted
        // uncomment next line if wanted this effect only while the tableView cells is being pressed
        //tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == headerTableView {
            tableView.deselectRow(at: indexPath, animated: true)
            showSearchBar()
        }
    }
    
}

// MARK: - Methods of UISearchBarDelegate

extension TransactionsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        hideSearchBar()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        hideSearchBar()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText(searchText)
        if searchText.isEmpty {
            hideSearchBar()
            updateInfoSearchBar()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                searchBar.resignFirstResponder()
            })
        }
     }
    
}

extension TransactionsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0.0 {
            showSearchBar()
        } else if scrollView.contentOffset.y > 0.0  {
            hideSearchBar()
        }
    }

}
