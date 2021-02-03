//
//  AppDelegate.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}



