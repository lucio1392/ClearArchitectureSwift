//
//  LoginNavigator.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import UIKit

protocol LoginNavigation {
    func toLoginURL()
    func toLogin()
}


final class LoginNavigator: LoginNavigation {
    
    private let useCaseProvider: UseCasesProvider
    private let navigationController: UINavigationController
    
    init(_ useCaseProvider: UseCasesProvider,
         navigationController: UINavigationController) {
        self.useCaseProvider = useCaseProvider
        self.navigationController = navigationController
    }
    
    func toLoginURL() {
        useCaseProvider.makeAuthenticationUseCaseProvider().redirectLogin()
    }
    
    func toLogin() {
        
    }
}

