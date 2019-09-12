//
//  AccessToken.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

public struct AccessToken: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Double
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case createdAt = "created_at"
    }
}

extension AccessToken: Equatable {
    
}
