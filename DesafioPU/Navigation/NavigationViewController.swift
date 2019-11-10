//
//  NavigationViewController.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor(red: 1/255, green: 85/255, blue: 203/255, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor(red: 1/255, green: 85/255, blue: 203/255, alpha: 1)
        self.hidesBarsOnSwipe = true
    }
}
