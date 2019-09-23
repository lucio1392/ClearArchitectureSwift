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
    func configSDK(window: UIWindow)
    func openLogin()
    func openPhotos()
}

final class Application: Applicationable {

    private var window: UIWindow!

    private var currentComponent: ComponentCoordinator?

    private let useCaseProvider: UseCasesProvider = UseCasesProviderPlatform()

    func configSDK(window: UIWindow) {
        self.window = window
    }

    func openLogin() {
        let loginComponentCoordinator = LoginComponentCoordinator(self.window)        
        loginComponentCoordinator.delegate = self
        let loginViewModel = LoginViewModel(useCaseProvider.makeAuthenticationUseCaseProvider(), loginCoordinator: loginComponentCoordinator)
        loginComponentCoordinator.transition(to: LoginScene.login(loginViewModel), type: .root, component: loginComponentCoordinator)
        currentComponent = loginComponentCoordinator
    }

    func openPhotos() {

    }

}

extension Application: LoginComponentDelegate {

    func didLogin() {
        print("Did Login")
    }

}
