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
    private let coordinator: LoginComponentCoordinator
    private let authenCode: PublishSubject<String> = PublishSubject<String>()
    
    init(_ authenUseCase: AuthenticationUseCase,
         loginCoordinator: LoginComponentCoordinator) {
        self.authenUseCase = authenUseCase
        self.coordinator = loginCoordinator
    }
    
    func transform(input: Input) -> Output {
        
        input
            .onLogin
            .drive(onNext: { [weak self] in
                guard let `self` = self else { return }
                let openAuthenViewModel = OpenAuthenticationViewModel(self.authenUseCase,
                                                                      coordinator: self.coordinator,
                                                                      authenCode: self.authenCode)
                self.coordinator.transition(to: LoginScene.authen(openAuthenViewModel), type: .present, component: self.coordinator)                
        })
            .disposed(by: disposedBag)
        
        let authenResult = authenCode
            .flatMap {
                self.authenUseCase.accessToken(code: $0)
        }.share()

//        authenResult.map { _ in }.bind(to: self.coordinator.didLoginSubject).disposed(by: disposedBag)


        let output = Output(authenResult: authenResult)
        return output
    }
    
}
