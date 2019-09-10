//
//  UserProvider.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import Moya

enum UserTarget {
    case accessToken(params: [String: String])
}

extension UserTarget: TargetType {
    
    var baseURL: URL {
        return URL(string: NetworkConfig.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .accessToken(_):
            return "oauth/token"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .accessToken(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding())
        }
    }
    
    var headers: [String : String]? {
        return ["Accept-Version": "v1"]
    }
    
    
}

