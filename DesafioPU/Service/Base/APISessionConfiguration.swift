//
//  APISessionConfiguration.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

protocol APIServiceConfiguration {
    var manager: URLSession { get }
}

extension APIServiceConfiguration {
    var manager: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.timeoutIntervalForRequest = 15.0
        configuration.httpAdditionalHeaders = ["Accept-Encoding": "gzip;q=1.0,compress;q=0.5"]
        
        return URLSession(configuration: configuration)
    }
}
