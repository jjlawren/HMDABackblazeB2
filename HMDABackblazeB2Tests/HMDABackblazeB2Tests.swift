//
//  HMDABackblazeB2Tests.swift
//  HMDABackblazeB2Tests
//
//  Created by Konstantinos Kontos on 17/12/2018.
//  Copyright © 2018 Handmade Apps Ltd. All rights reserved.
//

import XCTest
@testable import HMDABackblazeB2

class HMDABackblazeB2Tests: XCTestCase {

    var accountID: String? {
        return ProcessInfo.processInfo.environment["B2ACCOUNTID"]
    }
    
    var keyID: String? {
        return ProcessInfo.processInfo.environment["B2KEYID"]
    }
    
    var apiKey: String? {
        return ProcessInfo.processInfo.environment["B2APIKEY"]
    }
    
    lazy var b2Config: B2StorageConfig = {
        var config = B2StorageConfig()
        config.accountId = keyID
        config.applicationKey = apiKey
        
        return config
    }()
    
    var jsonAuthorize: String?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAuthorization() {
        
        let expect = XCTestExpectation(description: "Authorization")
        
        let jsonAuthorize = b2AuthorizeAccount(config: b2Config)
        
        NSLog("JSON Response:\n\n\(jsonAuthorize)")
        
        b2Config.processAuthorization(jsonStr: jsonAuthorize)
        
        if b2Config.accountAuthorizationToken != nil {
            expect.fulfill()
            
            NSLog("Obtained authorization: \(b2Config.accountAuthorizationToken!)")
        } else {
            XCTFail()
        }
        
    }
    
    func testListBuckets() {
        
        let expect = XCTestExpectation(description: "List Buckets")
        
        let jsonAuthorize = b2AuthorizeAccount(config: b2Config)
        b2Config.processAuthorization(jsonStr: jsonAuthorize)
        
        let json = b2ListBuckets(config: b2Config)
        
        NSLog("JSON Response:\n\n\(json)")
        
        if let jsonObject = try? JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: .mutableContainers) as! [String: Any] {
            
            if let buckets = jsonObject["buckets"] as? [[String: Any]] {
                expect.fulfill()
                
                NSLog("BUCKETS:\n\n\(buckets)")
            } else {
                XCTFail()
            }
            
        } else {
            XCTFail()
        }
        
        NSLog("JSON Response:\n\n\(json)")
        
    }
    
/*
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
*/

}
