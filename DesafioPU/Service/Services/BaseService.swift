//
//  CityServices.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

struct BaseService: APIServiceConfiguration, ServiceProtocol {
    func getDeals<T: Decodable>(router: APIRouter, completion: @escaping (Result<T>) -> Void) {
        var dataTask: URLSessionDataTask?
        dataTask?.cancel()
        
        let originalRequest =  router.asURLRequest()
        dataTask = self.manager.dataTask(with: originalRequest) { (data, response, error) in
            defer {
                dataTask = nil
            }
            if let error = error {
                completion(.failure(error))
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    let decodedObj = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedObj))
                } catch {
                    completion(.failure(error))
                }

            }
        }
        
        dataTask?.resume()
    }
}
