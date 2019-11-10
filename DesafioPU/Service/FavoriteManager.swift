//
//  FavoriteManager.swift
//  DesafioPU
//
//  Created by Guilherme Siepmann on 11/10/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import Foundation

class FavoriteManager {
    static var shared = FavoriteManager()
    private var defaults = UserDefaults.standard
    private var key = "favorites"
    
    private init() {}
    
    func addToFavorite(deal: Deal) {
        var currentFavorites = listFavorites()
        currentFavorites.append(deal)
        
        saveFavorites(deals: currentFavorites)
    }
    
    func removeFromFavorite(deal: Deal) {
        var currentFavorites = listFavorites()
        
        currentFavorites.removeAll(where: { $0.dealID == deal.dealID })
        saveFavorites(deals: currentFavorites)
    }
    
    func listFavorites() -> [Deal] {
        if let savedItens = defaults.object(forKey: key) as? Data {
            if let deals = try? JSONDecoder().decode(Array<Deal>.self, from: savedItens) {
                return deals
            }
        }
        return []
    }
    
    func isFavorited(deal: Deal) -> Bool {
        return listFavorites().contains(where: { $0.dealID == deal.dealID })
    }
    
    private func saveFavorites(deals: [Deal]) {
        if let encoded = try? JSONEncoder().encode(deals) {
            defaults.set(encoded, forKey: key)
            NotificationCenter.default.post(name: Notification.Name("updateBadgeIcon"), object: nil)
            NotificationCenter.default.post(name: Notification.Name("refreshFavorites"), object: nil)
        }
    }
}
