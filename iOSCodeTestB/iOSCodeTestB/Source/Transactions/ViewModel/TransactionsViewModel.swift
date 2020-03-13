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
    
    var transactions = Observable<Transactions>([], thread: .main)

    // TODO: Declare private var to store the filterText in seachBar with a didSet than updateData
    
    // The webservice call
    func retrieveTransactions() {
        
        debugPrint("retrieveTransactions - Retrieving transactions from Webservice..")

        // TODO: move this to a Constants static struct
        let url = "https://api.myjson.com/bins/1a30k8"
        //https://api.myjson.com/bins/rmw3u"
        //"https://api.myjson.com/bins/cvcay"
        
        AF.request(url).responseJSON {[weak self] response in
            
            guard let serverData = response.data, let transactions = try? JSONDecoder().decode(Transactions.self, from: serverData) else {
                debugPrint("retrieveTransactions - Can't decoding server response")
                return
            }
            
            self?.transactions.value = transactions
            //debugPrint("retrieveTransactions - Dump viewModel data stored:")
            //dump(self?.transactions.value)
            
            // TODO: short, etc..
            self?.transactions.value = self?.transactions.value?.transactionsWithDate
        }
        
    }
    
    // TODO: Update data with filterText
    
    // TODO: method in protocol that receive filter text from viewcontroller and update filterText viewModel var
    
}
