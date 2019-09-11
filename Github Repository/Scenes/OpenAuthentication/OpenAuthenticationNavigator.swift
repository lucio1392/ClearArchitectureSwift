//
//  OpenAuthenticationNavigator.swift
//  Github Repository
//
//  Created by Macbook on 9/11/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol OpenAuthenticationNavigation {
    func toOpenAuthentication()
    func toLogin()
}

final class OpenAuthenticationNavigator: OpenAuthenticationNavigation {
    
    private let navigationController: UINavigationController
    private let useCaseProvider: UseCasesProvider    
    private let authenCode: PublishSubject<String>
    
    init(_ navigationController: UINavigationController,
         useCaseProvider: UseCasesProvider,
         authenCode: PublishSubject<String>) {
        self.navigationController = navigationController
        self.useCaseProvider = useCaseProvider
        self.authenCode = authenCode
    }
    
    
    func toOpenAuthentication() {
        let openAuthenViewModel = OpenAuthenticationViewModel(useCaseProvider.makeAuthenticationUseCaseProvider(),
                                                              navigator: self,
                                                              authenCode: authenCode)
        let openAuthenViewController = OpenAuthenticationViewController(openAuthenViewModel)
        navigationController.present(openAuthenViewController, animated: true, completion: nil)
    }
    
    func toLogin() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
