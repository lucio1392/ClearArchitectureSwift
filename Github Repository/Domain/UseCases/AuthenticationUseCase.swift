//
//  AuthenticationUseCase.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import RxSwift



/// Authentication flow Interface.
///
/// This interface describe the full flow follwing OAUTH 2.0 protocol to get a User's AccessToken
public protocol AuthenticationUseCase {
    
    /// The Url request to redirect to login page for authentication
    var oauthRedirect: Observable<URLRequest> { get }
    
    /// Return an Access Token after request
    ///
    /// - Parameter code: The Code returned from **Open Authen** process
    /// - Returns: Return an Access Token after request
    func accessToken(code: String) -> Observable<AccessToken>
    
    
    /// Detect the authen code after **Login Process**
    ///
    /// - Parameters:
    ///   - param: Param want to get the value
    ///   - resultUrl: the redirect URI return from result
    /// - Returns: Value Code for get **Access Token**
    func openAuthen(param: String, resultUrl: URL) -> Observable<String>
}
