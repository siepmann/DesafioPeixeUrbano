//
//  NavigationViewController.swift
//  teste
//
//  Created by Guilherme Siepmann on 06/11/19.
//  Copyright © 2019 Guilherme Siepmann. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = .gray
        self.hidesBarsOnSwipe = true
    }
}
