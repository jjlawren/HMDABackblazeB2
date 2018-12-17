//
//  Upload.swift
//  HMDABackblazeB2
//
//  Created by Konstantinos Kontos on 17/12/2018.
//  Copyright © 2018 Handmade Apps Ltd. All rights reserved.
//

import Foundation

/*
public func b2ListFileNames(bucketId: String, startFileName: String?, maxFileCount: Int, config: B2StorageConfig) -> String {
    var jsonStr = ""
 
    if let url = config.apiUrl {
 
        let request = NSMutableURLRequest(url: url.appendingPathComponent("/b2api/v1/b2_list_file_names")!)
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
 
        var params = "{\"bucketId\":\"\(bucketId)\""
 
        if let startFileStr = startFileName {
            params += ",\"startFileName\":\"\(startFileStr)\""
        }
 
        if (maxFileCount > -1) {
            params += ",\"maxFileCount\":" + String(maxFileCount)
        }
 
        params += "}"
 
        request.httpBody = params.data(using: .utf8, allowLossyConversion: false)
 
        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
            jsonStr = NSString(data: requestData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        }
 
    }
 
    return jsonStr
}
*/

public func b2GetUploadUrl(bucketId: String, config: B2StorageConfig) -> String {
    var jsonStr = ""
    
    if let url = config.apiUrl {
        
        let request = NSMutableURLRequest(url: url.appendingPathComponent("/b2api/v1/b2_get_upload_url")!)
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["bucketId":"\(bucketId)"], options: .prettyPrinted)
        
        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
            jsonStr = NSString(data: requestData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        }
        
    }
    
    return jsonStr
}

public func b2UploadFile(fileUrl: NSURL, fileName: String, contentType: String, sha1: String, config: B2StorageConfig) -> String {
    var jsonStr = ""
    
    if let url = config.uploadUrl {
        
        if let fileData = NSData(contentsOf: fileUrl.absoluteURL!) {
        
            let request = NSMutableURLRequest(url: url.absoluteURL!)
            request.httpMethod = "POST"
            
            request.addValue(config.uploadAuthorizationToken!, forHTTPHeaderField: "Authorization")
            request.addValue(fileName, forHTTPHeaderField: "X-Bz-File-Name")
            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
            request.addValue(sha1, forHTTPHeaderField: "X-Bz-Content-Sha1")
            
            if let requestData = executeUploadRequest(request: request, uploadData: fileData, withSessionConfig: nil) {
                jsonStr = NSString(data: requestData as Data, encoding: String.Encoding.utf8.rawValue)! as String
            }
            
        }
        
    }
    
    return jsonStr
}
