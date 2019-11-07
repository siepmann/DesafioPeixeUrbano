//
//  APIFactory.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

struct APIFactory {
    static let shared = APIFactory()
    
    private init() { }
    
    var baseService = BaseService()
    
    
}

