//
//  Utils.swift
//  HMDABackblazeB2
//
//  Created by Konstantinos Kontos on 17/12/2018.
//  Copyright © 2018 Handmade Apps Ltd. All rights reserved.
//

import Foundation

public enum B2BucketType : String {
    case AllPublic = "allPublic"
    case AllPrivate = "allPrivate"
}

public func b2AuthorizeAccount(config: B2StorageConfig) -> String {
    var jsonStr = ""
    
    if let url = URL(string: "https://\(config.authServerStr)/b2api/v1/b2_authorize_account") {
        
        _ = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        
        let authStr = "\(config.accountId!):\(config.applicationKey!)"
        
        let authData = authStr.data(using: .utf8)
        
        let base64Str = authData!.base64EncodedString(options: .lineLength76Characters)
        
        request.httpMethod = "GET"
        
        let authSessionConfig = URLSessionConfiguration.default
        authSessionConfig.httpAdditionalHeaders = ["Authorization":"Basic \(base64Str)"]
        
        if let requestData = executeRequest(request: request, withSessionConfig: authSessionConfig) {
            jsonStr = NSString(data: requestData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        }
        
    }
    
    return jsonStr
}

public func executeRequest(request: NSMutableURLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?, andDelegate sessionDelegate: URLSessionDelegate) {
    let session: URLSession
    
    if (sessionConfig != nil) {
        session = URLSession(configuration: sessionConfig!, delegate: sessionDelegate, delegateQueue: nil)
    } else {
        session = URLSession(configuration: URLSessionConfiguration.ephemeral, delegate: sessionDelegate, delegateQueue: nil)
    }
    
    let task = session.dataTask(with: request as URLRequest)
    
    task.resume()
}

public func executeRequest(request: NSMutableURLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?) -> NSData? {
    let session: URLSession
    
    if (sessionConfig != nil) {
        session = URLSession(configuration: sessionConfig!)
    } else {
        session = URLSession.shared
    }
    
    var requestData: NSData?
    
    let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
        
        if error != nil {
            print("error: \(error!.localizedDescription)")
        }
            
        else if data != nil {
            requestData = NSData(data: data!)
        }
        
    }
    
    task.resume()
    
    // We need to sleep so that the task can finish.  It is a little
    // contrived I suppose.
    
    while (task.state != .completed && task.state != .canceling) {
        sleep(1)
    }
    
    return requestData
}

public func executeUploadRequest(request: NSMutableURLRequest, uploadData: NSData, withSessionConfig sessionConfig: URLSessionConfiguration?) -> NSData? {
    let session: URLSession
    
    if (sessionConfig != nil) {
        session = URLSession(configuration: sessionConfig!)
    } else {
        session = URLSession.shared
    }
    
    var requestData: NSData?
    
    let task = session.uploadTask(with: request as URLRequest, from: uploadData as Data) { (data, response, error) in
        
        if error != nil {
            print("error: \(error!.localizedDescription)")
        }
            
        else if data != nil {
            requestData = NSData(data: data!)
        }
        
    }
    
    task.resume()
    // We need to sleep so that the task can finish.  It is a little
    // contrived I suppose.
    
    while (task.state != .completed && task.state != .canceling) {
        sleep(1)
    }
    
    return requestData
}
