//
//  BaseComponentCoordinator.swift
//  Github Repository
//
//  Created by Lucio on 9/22/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxSwift

class BaseComponentCoordinator: ComponentCoordinator {

    var currentViewController: UIViewController?

    private var window: UIWindow!

    init(_ window: UIWindow, currentViewController: UIViewController?) {
        self.window = window
        self.currentViewController = currentViewController
    }

    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first!
        } else {
            return viewController
        }
    }

    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType, component: ComponentCoordinator) -> Completable {
        let subject = PublishSubject<Void>()
        let viewController = scene.viewController
        switch type {
        case .root:
            window.rootViewController = BaseComponentCoordinator.actualViewController(for: viewController)
            currentViewController = viewController
            window.makeKeyAndVisible()
            subject.onCompleted()
        case .push:
            guard let navigationController = currentViewController?.navigationController else {
                fatalError("Can not push to new View Controller without navigation")
            }
            _ = navigationController.rx.delegate.sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:))).map { _ in }.bind(to: subject)
            navigationController.pushViewController(viewController, animated: true)
            currentViewController = BaseComponentCoordinator.actualViewController(for: viewController)
        case .present:
            currentViewController?.present(viewController, animated: true) {
                subject.onCompleted()
            }
            currentViewController = BaseComponentCoordinator.actualViewController(for: viewController)
        }
        return subject.asObserver().take(1).ignoreElements()
    }

    @discardableResult
    func back(type: BackTransitionType) -> Completable {
        let subject = PublishSubject<Void>()

        switch type {
        case .dismiss(let animate):
            if let presenter = currentViewController?.presentingViewController {
                currentViewController?.dismiss(animated: animate) {
                    self.currentViewController = BaseComponentCoordinator.actualViewController(for: presenter)
                    subject.onCompleted()
                }
            }
        case .pop(let animate):
            if let navigationController = currentViewController?.navigationController {
                _ = navigationController.rx.delegate
                    .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                    .map { _ in }
                    .bind(to: subject)
                guard navigationController.popViewController(animated: animate) != nil else {
                    fatalError("can't navigate back from \(currentViewController)")
                }
                currentViewController = BaseComponentCoordinator.actualViewController(for: navigationController.viewControllers.last!)
            } else {
                fatalError("Not a modal, no navigation controller: can't navigate back from \(currentViewController)")
            }
        }

        return subject.asObservable()
            .take(1)
            .ignoreElements()
    }

}
