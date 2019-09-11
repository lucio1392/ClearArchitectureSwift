//
//  NetworkConfig.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

struct NetworkConfig {
    
    static let secretKey = "f85068b50290407337fbe6450f1f110617d6ed284650291312384752d4121dad"
    static let accessKey = "42451e131dd05989cb01773ffe5c344dbf45ca27c1afa302a0c220adba8c924f"
    
    static let baseUrl = "https://api.unsplash.com/"
    static let loginBaseUrl = "https://unsplash.com/"
    
    static let loginRedirect = NetworkConfig.loginBaseUrl + "oauth/authorize"
    static let redirectUri = "https://google.com/"
}
