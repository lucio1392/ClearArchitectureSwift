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
    
    struct Input {
        let authenCode: Observable<String>
    }
    
    struct Output {
        
    }
    
    private let authenUseCase: AuthenticationUseCase    
    
    init(_ authenUseCase: AuthenticationUseCase) {
        self.authenUseCase = authenUseCase
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
    
}
