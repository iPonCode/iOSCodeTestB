//  Observable.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 11/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

class Observable<T> {
    
    typealias Listener = (T?) -> Void
    
    private var listener: Listener?
    private let thread : DispatchQueue
    
    // receives any type of data and assigns it to the (same type) property
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value : T? { // This will run immediately after the value is stored
        didSet {
            thread.async { // not necessary, but it is done asynchronously
                self.listener?(self.value)
            }
        }
    }
    
    // Initialize in the main thread
    init(_ value : T? = nil, thread dispatcherThread : DispatchQueue = DispatchQueue.main) {
        self.thread = dispatcherThread
        self.value = value
    }
}
