//
//  DealsView.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

protocol DealsView: NSObjectProtocol {
    func showLoadingStatus()
    func hideLoadingStatus()
    func showErrorWith(message: String)
    func show(deals: DealModel)
}
