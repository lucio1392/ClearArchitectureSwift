//
//  LoginNavigator.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol LoginNavigation {
    func toLoginURL()
    func toLogin()
}


final class LoginNavigator: LoginNavigation {
    
    private let useCaseProvider: UseCasesProvider
    private let navigationController: UINavigationController
    private let authenCode: PublishSubject<String> = PublishSubject<String>()
    
    init(_ useCaseProvider: UseCasesProvider,
         navigationController: UINavigationController) {
        self.useCaseProvider = useCaseProvider
        self.navigationController = navigationController
    }
    
    func toLoginURL() {
       let openAuthenticationNavigation = OpenAuthenticationNavigator(navigationController,
                                                                      useCaseProvider: useCaseProvider,
                                                                      authenCode: authenCode)
        openAuthenticationNavigation.toOpenAuthentication()
    }
    
    func toLogin() {
        let loginViewModel = LoginViewModel(useCaseProvider.makeAuthenticationUseCaseProvider(),
                                            loginNavigator: self,
                                            authenCode: authenCode)
        let loginViewController = LoginViewController(loginViewModel)
        navigationController.pushViewController(loginViewController, animated: true)
    }
}

