//  Constants.swift
//  iOSCodeTestB
//
//  Created by Simón Aparicio on 15/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

// For readability and to have all about configuration located in one place

// MARK: - App Configuration

struct AppConfig {

    // TODO: File names
    
    // This private constructor is so that the structure cannot be instantiated,
    // since it will only have static constants and are defined here
    private init() {}
    
}

// MARK: - Api Configuration

struct ApiConfig {

    // URLs base for requests Servers
    static let baseURL: String = "https://api.myjson.com/bins/"

    enum EndPoint: String {
        case serverA = "1a30k8"
        case serverB = "197gmy"
        
        init(value: String){
            self = EndPoint(rawValue: value) ?? EndPoint.serverA
        }
    }

    // TODO: Declare headers for webservice here if needed

    private init() {}
    
}

