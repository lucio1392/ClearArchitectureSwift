//
//  AppDelegate.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
//        let hostApp = HostAppViewController()
//        let hostAppNavigation = UINavigationController(rootViewController: hostApp)
//        window?.rootViewController = hostAppNavigation
//        window?.makeKeyAndVisible()
//
        
        let application = Application.default
        application.delegate = self
        application.config(window!, transitionType: .root, currentViewController: nil)
        application.openPhotos()
        return true
    }
    
}

extension AppDelegate: SDKApplicationDelegate {
    
    func didOpenLogin() {
        print("Did open Login")
    }
    
    func didOpenPhotos() {
        print("Did open Photos")
    }
    
    func didLoginWith(accessToken: AccessToken) {
        print("New Access Token: \(accessToken.accessToken)")
    }
}
