//
//  MainCoordinator.swift
//  Payments
//
//  Created by Karen Rodriguez on 3/6/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit


class MainCoordinator: Coordinator {
    // App Window
    var window: UIWindow
    
    // CONTROLLERS
    var rootNavigationController: UINavigationController
    var mainController: MainViewController!
    
    /// View controller push or presented at the top of the app
    var topViewController: UIViewController? {
        if let presentedController = window.rootViewController?.presentedViewController {
            return presentedController
        } else {
            return window.rootViewController
        }
    }
    
    init(window: UIWindow) {
        self.window = window
        rootNavigationController = UINavigationController()
    }
    
    /// Starts coordinator and checks if the user is logged to go to home, otherwise go to Login
    func start() {
        /*
         Show Launch Screen for 3 seconds
         In production case we can download information in
         Launch ViewController
        */

        self.window.rootViewController = LaunchScreenViewController()
        self.window.makeKeyAndVisible()
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(startApp), userInfo: nil, repeats: false)
    }
    
    @objc func startApp() {
        rootNavigationController = CustomNavigationController()
        mainController = MainViewController()
        mainController?.coordinator = self
        rootNavigationController.pushViewController(mainController!, animated: false)
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.window.rootViewController = self.rootNavigationController
            self.window.makeKeyAndVisible()
        }, completion: nil)
    }
    
    func goToFrameworkDetail(with type: Framework) {
        switch type.type {
        case .requests:
            let requestsFrameworkVC = RequestsFrameworkViewController()
            requestsFrameworkVC.coordinator = self
            
            rootNavigationController.pushViewController(requestsFrameworkVC, animated: true)
        case .misc:
            break
        }
    }
    
    func showRequestDetail(with type: PaymentRouter) {
        let detailViewController = RequestDetailViewController()
        detailViewController.request = type
        detailViewController.modalTransitionStyle = .crossDissolve
        detailViewController.modalPresentationStyle = .overCurrentContext

        rootNavigationController.present(detailViewController, animated: true, completion: nil)
    }
}
