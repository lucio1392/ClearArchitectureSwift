//
//  Application.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol Applicationable {
    func openLogin()
    func openPhotos()
}

protocol SDKApplicationDelegate: class {
    func didOpenLogin()
    func didOpenPhotos()
    func didLoginWith(accessToken: AccessToken)
}

final class Application: Applicationable {
    
    static let `default` = Application()
    
    weak var delegate: SDKApplicationDelegate?
    
    private var transitionType: SceneTransitionType!
    
    private var coordinatorManage: CoordinatorManageType!
    
    private let disposeBag = DisposeBag()
    
    private init() {}
    
    func config(_ window: UIWindow,
                transitionType: SceneTransitionType,
                currentViewController: UIViewController?) {
        self.coordinatorManage = CoordinatorManage(window, currentViewController: currentViewController)
        self.transitionType = transitionType
    }
    
    func openLogin() {
        coordinatorManage.openLoginComponent(transition: transitionType)
        
        coordinatorManage
            .didLoginWithAccessToken
            .subscribe(onNext: { [weak self] accessToken in
                guard let `self` = self else { return }
                self.delegate?.didLoginWith(accessToken: accessToken)
        })
            .disposed(by: disposeBag)
        
        delegate?.didOpenLogin()
    }
    
    func openPhotos() {
        coordinatorManage.openPhotosComponent(transition: transitionType)
        delegate?.didOpenPhotos()
    }
    
}
