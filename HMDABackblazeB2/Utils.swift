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

public typealias B2CompletionHandler = (String?,Error?) -> Void

public typealias B2DataCompletionHandler = (Data?,Error?) -> Void

public typealias B2JSONObject = [String: Any]

public typealias B2JSONArray = [B2JSONObject]

public extension String {
 
    func toB2JSONObject() -> B2JSONObject? {
     
        if let stringData = self.data(using: .utf8) {
            let jsonObject = try? JSONSerialization.jsonObject(with: stringData, options: .mutableContainers) as! B2JSONObject
            
            return jsonObject
        } else {
            return nil
        }
        
    }
    
    func toB2JSONObject() -> B2JSONArray? {
        
        if let stringData = self.data(using: .utf8) {
            let jsonObject = try? JSONSerialization.jsonObject(with: stringData, options: .mutableContainers) as! B2JSONArray
            
            return jsonObject
        } else {
            return nil
        }
        
    }
    
}

public func b2AuthorizeAccount(config: B2StorageConfig, completionHandler: @escaping B2CompletionHandler) {
    
    if let url = URL(string: "https://\(config.authServerStr)/b2api/v1/b2_authorize_account") {
        
        var request = URLRequest(url: url)
        
        let authStr = "\(config.accountId!):\(config.applicationKey!)"
        
        let authData = authStr.data(using: .utf8)
        
        let base64Str = authData!.base64EncodedString(options: .lineLength76Characters)
        
        request.httpMethod = "GET"
        
        let authSessionConfig = URLSessionConfiguration.default
        authSessionConfig.httpAdditionalHeaders = ["Authorization":"Basic \(base64Str)"]

        executeRequest(request: request, withSessionConfig: authSessionConfig, completionHandler: completionHandler)
        
    } else {
        completionHandler(nil,nil)
    }
    
}

public func executeRequest(request: URLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?, completionHandler: @escaping B2CompletionHandler) {
    
    let session: URLSession
    
    if (sessionConfig != nil) {
        session = URLSession(configuration: sessionConfig!)
    } else {
        session = URLSession.shared
    }
    
    let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
        
        if error != nil {
            completionHandler(nil,error)
        } else if data != nil {
            let jsonStr = String(data: data!, encoding: .utf8)
            completionHandler(jsonStr,nil)
        } else {
            completionHandler(nil,nil)
        }
        
    }
    
    task.resume()
}

public func executeRequest(request: URLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?, completionHandler: @escaping B2DataCompletionHandler) {
    
    let session: URLSession
    
    if (sessionConfig != nil) {
        session = URLSession(configuration: sessionConfig!)
    } else {
        session = URLSession.shared
    }
    
    let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
        
        if error != nil {
            completionHandler(nil,error)
        } else if data != nil {
            completionHandler(data,nil)
        } else {
            completionHandler(nil,nil)
        }
        
    }
    
    task.resume()
}


public func executeRequest(request: URLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?, andDelegate sessionDelegate: URLSessionDelegate) {
    let session: URLSession
    
    if (sessionConfig != nil) {
        session = URLSession(configuration: sessionConfig!, delegate: sessionDelegate, delegateQueue: nil)
    } else {
        session = URLSession(configuration: URLSessionConfiguration.ephemeral, delegate: sessionDelegate, delegateQueue: nil)
    }
    
    let task = session.dataTask(with: request as URLRequest)
    
    task.resume()
}


public func executeUploadRequest(request: URLRequest, uploadData: Data, withSessionConfig sessionConfig: URLSessionConfiguration?, completionHandler: @escaping B2CompletionHandler) {
    let session: URLSession
    
    if (sessionConfig != nil) {
        session = URLSession(configuration: sessionConfig!)
    } else {
        session = URLSession.shared
    }
    
    let task = session.uploadTask(with: request as URLRequest, from: uploadData) { (data, response, error) in
        
        if error != nil {
            completionHandler(nil,error)
        } else if data != nil {
            let jsonStr = String(data: data!, encoding: .utf8)
            completionHandler(jsonStr,nil)
        } else {
            completionHandler(nil,nil)
        }
        
    }
    
    task.resume()
}


public func executeUploadRequest(request: URLRequest, file: URL, withSessionConfig sessionConfig: URLSessionConfiguration?, sessionDelegate: URLSessionDelegate) {
    let session: URLSession
    
    if (sessionConfig != nil) {
        session = URLSession(configuration: sessionConfig!, delegate: sessionDelegate, delegateQueue: nil)
    } else {
        session = URLSession(configuration: URLSessionConfiguration.ephemeral, delegate: sessionDelegate, delegateQueue: nil)
    }
    
    let task = session.uploadTask(with: request, fromFile: file)
    
    task.resume()
}

