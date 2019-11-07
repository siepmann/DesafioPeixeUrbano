//
//  ProductDealsRouter.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

enum ProductDealsRouter: APIRouter {
    case getProductDeals()
    
    var path: String {
        return APIConfig.ProductDeals.getDeals
    }
}
