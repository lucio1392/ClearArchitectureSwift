//
//  OpenAuthenticationViewModel.swift
//  Github Repository
//
//  Created by Macbook on 9/11/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class OpenAuthenticationViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let authenUrl: Observable<URL>
    }
    
    struct Output {
        let oauthRedirectURLRequest: Observable<URLRequest>
    }
    
    private let authenUseCase: AuthenticationUseCase
    private let navigator: OpenAuthenticationNavigation
    private let authenCode: PublishSubject<String>
    
    init(_ authenUseCase: AuthenticationUseCase,
         navigator: OpenAuthenticationNavigation,
         authenCode: PublishSubject<String>) {
        self.authenUseCase = authenUseCase
        self.navigator = navigator
        self.authenCode = authenCode
    }
    
    func transform(input: Input) -> Output {
        let input = input
                    .authenUrl
        
        let acceptAuthorize = input
            .filter { $0.absoluteString.contains("?code=") }
        
        
        let denyAuthorize = input
            .filter { $0.absoluteString.contains("?error=access_denied") }
        
        let authenCode = acceptAuthorize
            .flatMap {
                return self.authenUseCase.openAuthen(param: "code", resultUrl: $0)
            }
            .share()
        
        
        authenCode
            .subscribe(onNext: { code in
                self.navigator.toLogin()
            })
            .disposed(by: disposeBag)
        
        authenCode
            .bind(to: self.authenCode)
            .disposed(by: disposeBag)
        
        denyAuthorize
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.navigator.toLogin()
        })
            .disposed(by: disposeBag)
        
        
        return Output(oauthRedirectURLRequest: authenUseCase.oauthRedirect)
    }
    
    
}
