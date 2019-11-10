//
//  DealsPresenter.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

public class DealsPresenter {
    private let service: ServiceProtocol
    unowned private var dealsView: DealsView
    private let controllerType: ViewControllerType
    
    init(service: ServiceProtocol, viewControllerType: ViewControllerType, dealsView: DealsView) {
        self.service = service
        self.dealsView = dealsView
        self.controllerType = viewControllerType
    }
    
    func onStart() {
        dealsView.showLoadingStatus()
        switch self.controllerType {
        case .city:
            getCityDeals()
        case .product:
            getProductDeals()
        case .trip:
            getTripDeals()
        case .favorites:
            getFavoritedDeals()
        case .none:
            dealsView.showErrorWith(message: "")
        }
    }
    
    private func getCityDeals() {
        let router = CityDealsRouter.getCityDeals()
        service.getDeals(router: router) { [weak self] (result: Result<DealModel>) in
            if result.isSuccess, let value = result.value {
                self?.dealsView.show(deals: value)
            } else {
                self?.dealsView.showErrorWith(message: "")
            }
            self?.dealsView.hideLoadingStatus()
        }
    }
    
    private func getTripDeals() {
        let router = TripDealsRouter.getTripDeals()
        service.getDeals(router: router) { [weak self] (result: Result<DealModel>) in
            if result.isSuccess, let value = result.value {
                self?.dealsView.show(deals: value)
            } else {
                self?.dealsView.showErrorWith(message: "")
            }
            self?.dealsView.hideLoadingStatus()
        }
    }
    
    private func getProductDeals() {
        let router = ProductDealsRouter.getProductDeals()
        service.getDeals(router: router) { [weak self] (result: Result<DealModel>) in
            if result.isSuccess, let value = result.value {
                self?.dealsView.show(deals: value)
            } else {
                self?.dealsView.showErrorWith(message: "")
            }
            self?.dealsView.hideLoadingStatus()
        }
    }
    
    private func getFavoritedDeals() {
        self.dealsView.showFavorites(deals: FavoriteManager.shared.listFavorites())
    }
}
