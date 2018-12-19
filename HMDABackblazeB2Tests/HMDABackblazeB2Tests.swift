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

    var fileID: String? {
        return ProcessInfo.processInfo.environment["B2FILEID"]
    }
    
    var bucketID: String? {
        return ProcessInfo.processInfo.environment["B2BUCKETID"]
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
        
        let expect = XCTestExpectation(description: "Authorization")
        
        b2AuthorizeAccount(config: b2Config) { (jsonStr, error) in
            NSLog("AUTHORIZATION RESPONSE:\n\n\(jsonStr!)")
            
            if error == nil, jsonStr != nil {
                self.b2Config.processAuthorization(jsonStr: jsonStr!)
                expect.fulfill()
            } else {
                XCTFail()
                expect.fulfill()
            }
            
        }
        
        wait(for: [expect], timeout: 20.0)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListBuckets() {
        
        let expect = XCTestExpectation(description: "List Buckets")
        
        b2ListBuckets(config: b2Config) { (jsonStr, error) in
            NSLog("AUTHORIZATION RESPONSE:\n\n\(jsonStr!)")
            
            if error == nil, jsonStr != nil {
                expect.fulfill()
            } else {
                XCTFail()
                expect.fulfill()
            }
            
        }
        
        wait(for: [expect], timeout: 20.0)
    }
    
    
    func testListFiles() {
        
        guard bucketID != nil else {
            XCTFail()
            return
        }
        
        let expect = XCTestExpectation(description: "List Files")
        
        b2ListFileNames(config: b2Config,
                        bucketId: bucketID!,
                        startFileName: nil,
                        maxFileCount: 1000) { (jsonStr, error) in
                            NSLog("AUTHORIZATION RESPONSE:\n\n\(jsonStr!)")
                            
                            if error == nil, jsonStr != nil {
                                expect.fulfill()
                            } else {
                                XCTFail()
                                expect.fulfill()
                            }
        }
        
        wait(for: [expect], timeout: 20.0)
    }
    
    
    func testGetFileInfo() {
        
        guard fileID != nil else {
            XCTFail()
            return
        }
        
        let expect = XCTestExpectation(description: "List Files")
        
        b2GetFileInfo(config: b2Config, fileId: fileID!) { (jsonStr, error) in
            NSLog("AUTHORIZATION RESPONSE:\n\n\(jsonStr!)")
            
            if error == nil, jsonStr != nil {
                expect.fulfill()
            } else {
                XCTFail()
                expect.fulfill()
            }
        }
        
        wait(for: [expect], timeout: 20.0)
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
