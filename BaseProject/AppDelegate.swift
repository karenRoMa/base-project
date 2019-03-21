//
//  AppDelegate.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/7/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

/**
 Class to global configurations in the app depending on the active state
 */
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Stored Properties -
    
    /// Main window of the app
    var window: UIWindow?
    
    /// Main coordinator to define the app's flow
    var coordinator: MainCoordinator?
    
    /**
     When the app finish launching will set this configurations:
     - Coordinator Configuration:
        Create coordinator instance and windows for the full app and perform **start()** method
     - Handler Error Coordinator: set coordinator to HandlerError class
    */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        coordinator = MainCoordinator(window: window)
        
        HandlerError.shared.coordinator = coordinator

        coordinator?.start()
        
        return true
    }

    /**
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     
     Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
     */
    func applicationWillResignActive(_ application: UIApplication) {

    }

    /**
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    */
    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    /**
     Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    */
    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    /**
      Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    */
    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    /**
     Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     */
    func applicationWillTerminate(_ application: UIApplication) {

    }


}

