//
//  AuthenticationUseCasePlatform.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxSwift

final class AuthenticationUseCasePlatform: AuthenticationUseCase {
    
    private let network = Network<AccessToken ,UserTarget>()
    
    func accessToken(code: String) -> Observable<AccessToken> {
        return network.getItem(.accessToken(params: ["client_id": NetworkConfig.accessKey,
                                                     "client_secret": NetworkConfig.secretKey,
                                                     "redirect_uri": "",
                                                     "code": code,
                                                     "grant_type": "authorization_code"]))
    }
    
    func redirectLogin() {
        UIApplication.shared.open(URL(string: NetworkConfig.loginRedirect)!, options: [:], completionHandler: nil)
    }
    
    
}
