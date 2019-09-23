//
//  CoordinatorManage.swift
//  Github Repository
//
//  Created by Macbook on 9/23/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol CoordinatorManageType {
    var currentComponent: ComponentCoordinator? { get }
    
    func openLoginComponent(transition: SceneTransitionType)
    func openPhotosComponent(transition: SceneTransitionType)
    
    var didLoginWithAccessToken: PublishSubject<AccessToken> { get set }
}

class CoordinatorManage: CoordinatorManageType {
    
    var currentComponent: ComponentCoordinator?
    
    private let useCaseProvider: UseCasesProvider = UseCasesProviderPlatform()
    private let disposeBag = DisposeBag()
    
    private var window: UIWindow
    private var currentViewController: UIViewController?
    
    var didLoginWithAccessToken: PublishSubject<AccessToken> = PublishSubject<AccessToken>()
    
    init(_ window: UIWindow, currentViewController: UIViewController?) {
        self.window = window
        if currentViewController == nil {
            self.currentViewController = currentComponent?.currentViewController
        } else {
            self.currentViewController = currentViewController
        }
    }
    
    func openLoginComponent(transition: SceneTransitionType) {
        let loginComponentCoordinator = LoginComponentCoordinator(self.window, currentViewController: currentComponent?.currentViewController ?? self.currentViewController)
        
        loginComponentCoordinator
            .didLoginWithAccessToken
            .bind(to: didLoginWithAccessToken)
            .disposed(by: disposeBag)
        
        loginComponentCoordinator
            .didLoginWithAccessToken
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.openPhotosComponent(transition: .present)
        })
            .disposed(by: disposeBag)
        
        let loginViewModel = LoginViewModel(useCaseProvider.makeAuthenticationUseCaseProvider(), loginCoordinator: loginComponentCoordinator)
        loginComponentCoordinator.transition(to: LoginScene.login(loginViewModel), type: transition, component: loginComponentCoordinator)
        currentComponent = loginComponentCoordinator
    }
    
    func openPhotosComponent(transition: SceneTransitionType) {
        print("CurrentComponentVC: \(currentComponent?.currentViewController) - CoordinatorCurrentVC: \(self.currentViewController)")
        let photosComponentCoordinator = PhotoComponentCoordinator(self.window, currentViewController: currentComponent?.currentViewController ?? self.currentViewController)
        let photosViewModel = PhotosViewModel(useCaseProvider.makePhotoUseCaseProvider(), photosCoordinator: photosComponentCoordinator)
        photosComponentCoordinator.transition(to: PhotosScene.photos(photosViewModel), type: transition, component: photosComponentCoordinator)
        currentComponent = photosComponentCoordinator
    }
    
}
