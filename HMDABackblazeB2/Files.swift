//
//  Files.swift
//  HMDABackblazeB2
//
//  Created by Konstantinos Kontos on 17/12/2018.
//  Copyright © 2018 Handmade Apps Ltd. All rights reserved.
//

import Foundation

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

public func b2ListFileVersions(bucketId: String, startFileName: String?, startFileId: String?, maxFileCount: Int, config: B2StorageConfig) -> String {
    var jsonStr = ""
    
    if let url = config.apiUrl {
        
        let request = NSMutableURLRequest(url: url.appendingPathComponent("/b2api/v1/b2_list_file_versions")!)
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        
        var params = "{\"bucketId\":\"\(bucketId)\""
        
        if let startFileNameStr = startFileName {
            params += ",\"startFileName\":\"\(startFileNameStr)\""
        }
        
        if let startFileIdStr = startFileId {
            params += ",\"startFileId\":\"\(startFileIdStr)\""
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

public func b2GetFileInfo(fileId: String, config: B2StorageConfig) -> String {
    var jsonStr = ""
    
    if let url = config.apiUrl {
        
        let request = NSMutableURLRequest(url: url.appendingPathComponent("/b2api/v1/b2_get_file_info")!)
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        
        request.httpBody = "{\"fileId\":\"\(fileId)\"}".data(using: .utf8, allowLossyConversion: false)
        
        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
            jsonStr = NSString(data: requestData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        }
        
    }
    
    return jsonStr
}

public func b2DeleteFileVersion(fileId: String, fileName: String, config: B2StorageConfig) -> String {
    var jsonStr = ""
    
    if let url = config.apiUrl {
        
        let request = NSMutableURLRequest(url: url.appendingPathComponent("/b2api/v1/b2_delete_file_version")!)
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        
        request.httpBody = "{\"fileName\":\"\(fileName)\",\"fileId\":\"\(fileId)\"}".data(using: .utf8, allowLossyConversion: false)
        
        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
            jsonStr = NSString(data: requestData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        }
        
    }
    
    return jsonStr
}

public func b2HideFile(bucketId: String, fileName: String, config: B2StorageConfig) -> String {
    var jsonStr = ""
    
    if let url = config.apiUrl {
        
        let request = NSMutableURLRequest(url: url.appendingPathComponent("/b2api/v1/b2_hide_file")!)
        request.httpMethod = "POST"
        request.addValue(config.accountAuthorizationToken!, forHTTPHeaderField: "Authorization")
        
        request.httpBody = "{\"fileName\":\"\(fileName)\",\"bucketId\":\"\(bucketId)\"}".data(using: .utf8, allowLossyConversion: false)
        
        if let requestData = executeRequest(request: request, withSessionConfig: nil) {
            jsonStr = NSString(data: requestData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        }
        
    }
    
    return jsonStr
}
