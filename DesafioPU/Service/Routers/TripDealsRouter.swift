//
//  TripDealsRouter.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

enum TripDealsRouter: APIRouter {
    case getTripDeals()
    
    var path: String {
        return APIConfig.TripDeals.getDeals
    }
}
