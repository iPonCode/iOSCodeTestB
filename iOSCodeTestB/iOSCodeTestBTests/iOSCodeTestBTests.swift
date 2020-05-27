//  iOSCodeTestBTests.swift
//  iOSCodeTestBTests
//
//  Created by Simón Aparicio on 10/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import XCTest
@testable import iOSCodeTestB

class iOSCodeTestBTests: XCTestCase {

    private var viewModel : TransactionsViewModelImpl!

    override func setUp() {
        viewModel = TransactionsViewModelImpl()
    }

    override func tearDown() {
        viewModel = nil
    }

    func testSetCurrentEndPoint() {
        
        // Given
        let endPointSettedToServerB : ApiConfig.EndPoint = .serverB
        
        // When
        viewModel.setCurrentEndPoint(endPointSettedToServerB)
        
        // Then
        XCTAssertEqual(viewModel.getCurrentEndPoint(), endPointSettedToServerB)
    }

    func testGetCurrentEndPoint() {
        
        // Given
        let endPointGetted : ApiConfig.EndPoint
        let espectedEndPointServerA: ApiConfig.EndPoint = .serverA
        
        // When
        endPointGetted = viewModel.getCurrentEndPoint()
        
        // Then
        XCTAssertEqual(endPointGetted, espectedEndPointServerA)
    }

}
