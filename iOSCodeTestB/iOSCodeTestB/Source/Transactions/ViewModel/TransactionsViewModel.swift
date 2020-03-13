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
        //"https://api.myjson.com/bins/rmw3u"
        //"https://api.myjson.com/bins/cvcay"
        
        AF.request(url).responseJSON {[weak self] response in
            
            guard let serverData = response.data, let transactions = try? JSONDecoder().decode(Transactions.self, from: serverData) else {
                debugPrint("retrieveTransactions - Can't decoding server response")
                return
            }
            
            //guard let `self` = self else{ return }
            
            // Clean items with wrong formatted dates, sort descending by date and remove duplicates by id
            self?.transactions.value = transactions.onlyDatedTransactions
                    .sorted(by: { $0.date! > $1.date! })
                    .removingDuplicates()//.unique
        }
        
    }
        
    // TODO: Update data with filterText
    
    // TODO: method in protocol that receive filter text from viewcontroller and update filterText viewModel var

}
