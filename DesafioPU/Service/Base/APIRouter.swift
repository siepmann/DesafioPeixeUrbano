//
//  APIRouter.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

public protocol APIRouter {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
}

extension APIRouter {
    public var baseURL: String {
        return APIConfig.baseAPIUrl
    }
    
    public var method: String {
        return "GET"
    }
}

extension APIRouter {
    func asURLRequest() -> URLRequest {
        let baseURL = URL(string: self.baseURL)
        let mutableURLRequest = NSMutableURLRequest(url: baseURL!.appendingPathComponent(self.path))
        
        mutableURLRequest.httpMethod = self.method
        mutableURLRequest.timeoutInterval = 15.0
        mutableURLRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        return mutableURLRequest as URLRequest
    }
}
