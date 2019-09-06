//
//  PhotoProvider.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation
import Moya

enum PhotoTarget {
    case photos
}

extension PhotoTarget: TargetType {
    
    var sampleData: Data {
        return Data()
    }
    
    var baseURL: URL {
        return URL(string: NetworkConfig.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .photos:
            return "photos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Accept-Version": "v1",
                "Authorization": "Client-ID \(NetworkConfig.secretKey)"]
    }
    
}
