//
//  Coordinator.swift
//  Github Repository
//
//  Created by Lucio on 9/22/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxSwift

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
