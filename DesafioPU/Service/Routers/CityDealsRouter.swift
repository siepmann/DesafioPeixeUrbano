//
//  CityDealsRouter.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

enum CityDealsRouter: APIRouter {
    case getCityDeals()
    
    var path: String {
        return APIConfig.CityDeals.getDeals
    }
}
