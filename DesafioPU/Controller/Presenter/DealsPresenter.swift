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
    private let controllerType: DealsViewControllerType
    
    init(service: ServiceProtocol, viewControllerType: DealsViewControllerType, dealsView: DealsView) {
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
        }
    }
    
    private func getCityDeals() {
        let router = CityDealsRouter.getCityDeals()
        service.getDeals(router: router) { [weak self] (result: Result<DealModel>) in
            if result.isSuccess, let value = result.value {
                self?.dealsView.show(deals: value)
            } else {
                self?.dealsView.showErrorWith(message: "Erro ao consultar dados, tente novamente.")
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
                self?.dealsView.showErrorWith(message: "Erro ao consultar dados, tente novamente.")
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
                self?.dealsView.showErrorWith(message: "Erro ao consultar dados, tente novamente.")
            }
            self?.dealsView.hideLoadingStatus()
        }
    }
    
    private func getFavoritedDeals() {
        let favorites = FavoriteManager.shared.listFavorites()
        if favorites.count > 0 {
            self.dealsView.showFavorites(deals: FavoriteManager.shared.listFavorites())
        } else {
            self.dealsView.showErrorWith(message: "Nenhum item encontrado como favorito.")
        }
        
    }
}
