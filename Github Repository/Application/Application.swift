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
    
    private let usecaseProvider: UseCasesProvider
    
    private init() {
        self.usecaseProvider = UseCasesProviderPlatform()
    }
    
    func configureMainInterface(window: UIWindow) {
        let photosNavigationController = UINavigationController()
        
//        let photosNavigator = PhotosNavigator(usecaseProvider,
//                                             navigationController: photosNavigationController)
        
        let loginNavigator = LoginNavigator(usecaseProvider, navigationController: photosNavigationController)

        window.rootViewController = photosNavigationController
        window.makeKeyAndVisible()
        loginNavigator.toLogin()
//        photosNavigator.toPhotos()
    }
    
}
