//
//  LoginComponentCoordinator.swift
//  Github Repository
//
//  Created by Lucio on 9/22/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxSwift

enum LoginScene: Scene {
    
    case login(LoginViewModel)
    case authen(OpenAuthenticationViewModel)
    
    var viewController: UIViewController {
        switch self {
        case .login(let viewModel):
            let loginViewController = LoginViewController(viewModel)
            return loginViewController
        case .authen(let viewModel):
            let openAuthenViewController = OpenAuthenticationViewController(viewModel)
            return openAuthenViewController
        }
        
    }
}

class LoginComponentCoordinator: BaseComponentCoordinator {

    var didLoginWithAccessToken: PublishSubject<AccessToken> = PublishSubject<AccessToken>()
    
}
