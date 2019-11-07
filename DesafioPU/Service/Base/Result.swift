//
//  Result.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }
}

extension Result: CustomStringConvertible {
    public var description: String {
        switch self {
        case .success:
            return "SUCCESS"
        case .failure:
            return "FAILURE"
        }
    }
    
}

extension Result: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .success(let value):
            return "SUCCESS: \(value)"
        case .failure(let error):
            return "FAILURE: \(error)"
        }
    }
}
