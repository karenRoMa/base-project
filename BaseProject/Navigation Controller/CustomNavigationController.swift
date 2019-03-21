//
//  CustomNavigationController.swift
//  Payments
//
//  Created by Karen Rodriguez on 3/6/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit


// - Tag:

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        // TODO: Custom Navigation Controller configuration
        #warning("Configure CustomNavigationController class, in case that the project doesn't need a custom configuration delete this file and use UINavigationController in the Coordinator protocol. When you add configuration delete this warning")
    }
}
