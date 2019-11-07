//
//  MainViewController.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createNavigationBarButtons()
        
        let cityDealsViewController = ViewController(with: .city)
        let cityDealsBarItem = UITabBarItem(title: "teste 1", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
        cityDealsViewController.tabBarItem = cityDealsBarItem
        
        let tripDealsViewController = ViewController(with: .trip)
        let tripDealsBarItem = UITabBarItem(title: "teste 2", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
        tripDealsViewController.tabBarItem = tripDealsBarItem

        let productDealsViewController = ViewController(with: .product)
        let productDealsBarItem = UITabBarItem(title: "teste 3", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
        productDealsViewController.tabBarItem = productDealsBarItem
        
        self.viewControllers = [cityDealsViewController, tripDealsViewController, productDealsViewController]
    }
    
    private func createNavigationBarButtons() {
        let logoutBarButtonItem = BadgeBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(favoritedItems))
        
        self.navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    @objc func favoritedItems(){
        print("clicked")
    }
}
