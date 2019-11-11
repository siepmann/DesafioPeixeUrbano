//
//  MainViewController.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavoriteBadge), name: Notification.Name("updateBadgeIcon"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createNavigationBarButtons()
        
        let cityDealsViewController = DealsViewController(with: .city)
        
        let cityDealsBarItem = UITabBarItem(title: "Na cidade", image: #imageLiteral(resourceName: "City"), tag: 0)
        cityDealsViewController.tabBarItem = cityDealsBarItem
        
        let tripDealsViewController = DealsViewController(with: .trip)
        let tripDealsBarItem = UITabBarItem(title: "Viagens", image: #imageLiteral(resourceName: "Trip"), tag: 1)
        tripDealsViewController.tabBarItem = tripDealsBarItem

        let productDealsViewController = DealsViewController(with: .product)
        let productDealsBarItem = UITabBarItem(title: "Produtos", image: #imageLiteral(resourceName: "Products"), tag: 2)
        productDealsViewController.tabBarItem = productDealsBarItem
        
        self.tabBar.tintColor = UIColor.orange
        
        updateFavoriteBadge()
        
        self.viewControllers = [cityDealsViewController, tripDealsViewController, productDealsViewController]
    }
    
    private func createNavigationBarButtons() {
        let logoutBarButtonItem = BadgeBarButtonItem(image: #imageLiteral(resourceName: "FavIconOff"), style: .done, target: self, action: #selector(favoritedItems))
        logoutBarButtonItem.tintColor = .white
        self.navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    @objc func updateFavoriteBadge() {
        let count = FavoriteManager.shared.listFavorites().count
        
        if let button = self.navigationItem.rightBarButtonItem as? BadgeBarButtonItem {
            button.badgeNumber = count
        }
        
    }
    
    @objc func favoritedItems() {
        let favorites = DealsViewController(with: .favorites)
        favorites.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(favorites, animated: true)
    }
}
