//
//  AppDelegate.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureWindow()
        return true
    }

    // MARK: - Private Setup
    private func configureWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = PortalVC()
        window?.makeKeyAndVisible()
    }
}
