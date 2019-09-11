//
//  LoginViewModel.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel: ViewModelType {
    
    private let disposedBag = DisposeBag()
    
    struct Input {
        let onLogin: Driver<Void>
    }
    
    struct Output {
        let authenResult: Observable<AccessToken>
    }
    
    //MARK: Private
    private let authenUseCase: AuthenticationUseCase    
    private let loginNavigator: LoginNavigation
    private let authenCode: PublishSubject<String>
    
    init(_ authenUseCase: AuthenticationUseCase,
         loginNavigator: LoginNavigation,
         authenCode: PublishSubject<String>) {
        self.authenUseCase = authenUseCase
        self.loginNavigator = loginNavigator
        self.authenCode = authenCode
    }
    
    func transform(input: Input) -> Output {
        
        input
            .onLogin
            .drive(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.loginNavigator.toLoginURL()
        })
            .disposed(by: disposedBag)
        
        let authenResult = authenCode
            .flatMap {
                self.authenUseCase.accessToken(code: $0).share()
        }
        
        let output = Output(authenResult: authenResult)
        return output
    }
    
}
