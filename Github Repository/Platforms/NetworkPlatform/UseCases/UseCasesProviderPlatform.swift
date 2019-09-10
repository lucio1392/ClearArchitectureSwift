//
//  UseCasesProviderPlatform.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

public final class UseCasesProviderPlatform: UseCasesProvider {
    
    public func makeAuthenticationUseCaseProvider() -> AuthenticationUseCase {
        return AuthenticationUseCasePlatform()
    }
    
    
    public func makePhotoUseCaseProvider() -> PhotoUseCase {
        return PhotoUseCasePlatform()
    }
    
}
