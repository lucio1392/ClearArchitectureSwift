//
//  AuthenticationUseCase.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxSwift

public protocol AuthenticationUseCase {    
    func accessToken(code: String) -> Observable<AccessToken>
    func redirectLogin()
}
