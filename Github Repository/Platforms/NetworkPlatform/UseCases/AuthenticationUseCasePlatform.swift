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
    
    var oauthRedirect: Observable<URLRequest> {
        return .just(URLRequest(url: URL(string: "https://unsplash.com/oauth/authorize" + "?client_id=\(NetworkConfig.accessKey)&scope=public&response_type=code&redirect_uri=\(NetworkConfig.redirectUri)")!))
    }
    
    func accessToken(code: String) -> Observable<AccessToken> {
        return network.getItem(.accessToken(params: ["client_id": NetworkConfig.accessKey,
                                                     "client_secret": NetworkConfig.secretKey,
                                                     "redirect_uri": NetworkConfig.redirectUri,
                                                     "code": code,
                                                     "grant_type": "authorization_code"]))
    }
    
    
    func openAuthen(param: String, resultUrl: URL) -> Observable<String> {
        return Observable.create { observer in
            
            guard let components = URLComponents(url: resultUrl, resolvingAgainstBaseURL: false) else {
                observer.onCompleted()
                return Disposables.create()
            }
            guard let queryItems = components.queryItems else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            let finalAuthen = queryItems.filter { item in item.name == param }.first?.value
            
            observer.onNext(finalAuthen ?? "")
            
            return Disposables.create()
        }
    }
    
}
