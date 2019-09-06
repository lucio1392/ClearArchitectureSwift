//
//  Application.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import UIKit

protocol Applicationable {
    func configureMainInterface(window: UIWindow)
}

final class Application: Applicationable {
    
    static let `default` = Application()
    
    private let networkUsecaseProvider: UseCasesProvider
    
    private init() {
        self.networkUsecaseProvider = UseCasesProviderPlatform()
    }
    
    func configureMainInterface(window: UIWindow) {
        let tabbarController = UITabBarController()
        
        let photosNavigationController = UINavigationController()
        tabbarController.tabBarItem = UITabBarItem(title: "Photos", image: nil, selectedImage: nil)
        let photosNavigator = PhotoNavigator(networkUsecaseProvider,
                                             navigationController: photosNavigationController)
        
        tabbarController.viewControllers = [photosNavigationController]
        window.rootViewController = tabbarController
    }
    
}
