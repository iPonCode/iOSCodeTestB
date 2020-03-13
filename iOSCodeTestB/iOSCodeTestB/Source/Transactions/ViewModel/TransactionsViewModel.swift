//  TransactionsViewModel.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 11/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation
import Alamofire

protocol TransactionsViewModel {
    
    var transactions: Observable<Transactions> {get}
    var firstTransaction: Observable<Transaction> {get}

    func retrieveTransactions()
    func searchText(_ text: String)
}

// Here the business logic
class TransactionsViewModelImpl: TransactionsViewModel {
    
    var transactions = Observable<Transactions>([], thread: .main)
    var firstTransaction = Observable<Transaction>(nil, thread: .main)
    var localTransactions: [Transaction] = []

    private var filterText: String = "" {
        didSet {
            updateTransactionsWithFilter()
        }
    }

    // The webservice call
    func retrieveTransactions() {
        
        debugPrint("retrieveTransactions - Retrieving transactions from Webservice..")

        // TODO: move this to a Constants static struct
        let url = "https://api.myjson.com/bins/1a30k8" //1a30k8//13a73a//j3tee//rmw3u//cvcay//16okye//1gsy8m
        
        AF.request(url).responseJSON {[weak self] response in
            
            guard let serverData = response.data, let transactions = try? JSONDecoder().decode(Transactions.self, from: serverData) else {
                debugPrint("retrieveTransactions - Can't decoding server response")
                return
            }
            
            //guard let `self` = self else{ return }
            
            // Remove duplicates by id Clean items with wrong formatted dates, sort descending by date and
            self?.transactions.value = transactions.removingDuplicates()
                    .onlyDatedTransactions
                .sorted(by: { $0.date! > $1.date! })
                    //.unique
            self?.firstTransaction.value = self?.transactions.value?.first
            self?.transactions.value = Array((self?.transactions.value?.dropFirst() ?? []))
            self?.localTransactions = self?.transactions.value ?? []

        }
        
    }
        
    func updateTransactionsWithFilter () {
        
        if !filterText.isEmpty {
            transactions.value = localTransactions.filter({
                ($0.description ?? "").lowercased().contains(filterText.lowercased())
            })

        } else {
            transactions.value = localTransactions
        }
    }
    
    func searchText(_ text: String) {
        filterText = text
    }

}
