//
//  QuantumSwiftTests.swift
//  QuantumSwiftTests
//
//  Created by Wojciech Charysz on 10.05.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import XCTest
@testable import QuantumSwift

class QuantumSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let qpp = ObjCqpp()
        //qpp.minimal()
        //qpp.qubitsRequired(for: 65537)
        //qpp.shor(for: 17)
        //qpp.grover(for: 27)
        qpp.grover(for: 27, in: [1, 2, 3, 4, 5, 10, 17, 27, 30])
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let qpp = ObjCqpp()
            qpp.grover(for: 27, in: [1, 2, 3, 4, 5, 10, 17, 27, 30])
        }
    }
    
}
