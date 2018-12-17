//
//  Download.swift
//  HMDABackblazeB2
//
//  Created by Konstantinos Kontos on 17/12/2018.
//  Copyright © 2018 Handmade Apps Ltd. All rights reserved.
//

import Foundation

public func b2DownloadFileById(fileId: String, config: B2StorageConfig, andDelegate sessionDelegate: URLSessionDelegate) {

    if let url = config.downloadUrl {
        let request = NSMutableURLRequest(url: url.appendingPathComponent("/b2api/v1/b2_download_file_by_id")!)
        
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["fileId":"\(fileId)"], options: .prettyPrinted)
        
        executeRequest(request: request, withSessionConfig: nil, andDelegate: sessionDelegate)
    }
    
}

public func b2DownloadFileById(fileId: String, config: B2StorageConfig) -> NSData? {
    var downloadedData: NSData? = nil
    
    if let url = config.downloadUrl {
        
        let request = NSMutableURLRequest(url: url.appendingPathComponent("/b2api/v1/b2_download_file_by_id")!)
        
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["fileId":"\(fileId)"], options: .prettyPrinted)
        
        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
            downloadedData = requestData
        }
        
    }
    
    return downloadedData
}

public func b2DownloadFileByIdEx(fileId: String, config: B2StorageConfig, andDelegate sessionDelegate: URLSessionDelegate) {
    
    if let url = config.downloadUrl {
        
        if let urlComponents = NSURLComponents(string: "\(url.absoluteString!)/b2api/v1/b2_download_file_by_id") {
            urlComponents.query = "fileId=\(fileId)"
            
            let request = NSMutableURLRequest(url: urlComponents.url!)
            request.httpMethod = "GET"
            request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
            
            executeRequest(request: request, withSessionConfig: nil, andDelegate: sessionDelegate)
        }
        
    }
    
}

public func b2DownloadFileByIdEx(fileId: String, config: B2StorageConfig) -> NSData? {
    var downloadedData: NSData? = nil
    
    if let url = config.downloadUrl {

        if let urlComponents = NSURLComponents(string: "\(url.absoluteString!)/b2api/v1/b2_download_file_by_id") {
            urlComponents.query = "fileId=\(fileId)"
        
            let request = NSMutableURLRequest(url: urlComponents.url!)
            request.httpMethod = "GET"
            request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
            
            if let requestData = executeRequest(request: request, withSessionConfig: nil) {
                downloadedData = requestData
            }
            
        }
        
    }
    
    return downloadedData
}
