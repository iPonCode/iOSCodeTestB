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

    // TODO: Declare the methods will need use from viewcontroller like retrieve data or filter text
    func retrieveTransactions()
}

// Here the business logic
class TransactionsViewModelImpl: TransactionsViewModel {
    
    // TODO: Initialize the Observable data var
    var transactions = Observable<Transactions>([], thread: .main)

    // TODO: Declare private var to store the filterText in seachBar with a didSet than updateData
    
    // TODO: Webservice call
    
    func retrieveTransactions() {
        
        debugPrint("retrieveTransactions - Retrieving transactions from Webservice..")
        let url = "https://api.myjson.com/bins/1a30k8" // TODO: move this to a Constants static struct
        AF.request(url).responseJSON {[weak self] response in
            
            guard let serverData = response.data, let transactions = try? JSONDecoder().decode(Transactions.self, from: serverData) else {
                debugPrint("retrieveTransactions - Can't decoding server response")
                return
            }
            
            self?.transactions.value = transactions
            //debugPrint("retrieveTransactions - Dump viewModel data stored:")
            //dump(self?.transactions.value)
            // TODO: filter, short, etc..
        }
        
    }
    
    // TODO: Update data with filterText
    
    // TODO: method in protocol that receive filter text from viewcontroller and update filterText viewModel var
    
}
