//
//  Coordinator.swift
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

protocol Scene {
    var viewController: UIViewController { get }
}

enum SceneTransitionType {
    case push
    case root
    case present
}

enum BackTransitionType {
    case dismiss(animate: Bool)
    case pop(animate: Bool)
}

protocol ComponentCoordinator: class {

    var currentViewController: UIViewController? { get set }

    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType, component: ComponentCoordinator) -> Completable

    @discardableResult
    func back(type: BackTransitionType) -> Completable
}

extension ComponentCoordinator {
    @discardableResult
    func dismiss() -> Completable {
        return back(type: .dismiss(animate: true))
    }
    
    @discardableResult
    func pop() -> Completable {
        return back(type: .pop(animate: true))
    }
}
