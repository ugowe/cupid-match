//
//  CupidMatchTests.swift
//  CupidMatchTests
//
//  Created by Joseph Ugowe on 4/8/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import XCTest
@testable import CupidMatch

class CupidMatchTests: XCTestCase {
    
    var urlSessionTest: URLSession?
    var matchEndpoint = "https://www.okcupid.com/matchSample.json"
    
    override func setUp() {
        urlSessionTest = URLSession(configuration: .default)
        super.setUp()
    }
    
    override func tearDown() {
        urlSessionTest = nil
        super.tearDown()
    }
    
    func testExample() {
    }
    
    func testResponse() {
        guard let url = URL(string: matchEndpoint) else { return }
        let statusCodeExpectation = expectation(description: "Status code: 200")
        
        let dataTask = urlSessionTest?.dataTask(with: url) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    statusCodeExpectation.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        
        dataTask?.resume()
        waitForExpectations(timeout: 7, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
        }
    }
    
}
