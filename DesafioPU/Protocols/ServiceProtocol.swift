//
//  ServiceProtocol.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    func getDeals<T: Decodable>(router: APIRouter, completion: @escaping (Result<T>) -> Void)
}
