//
//  PhotosError.swift
//  Github Repository
//
//  Created by Macbook on 9/10/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

public struct PhotosError: Decodable {
    
    private let errors: [String]
    var statusCode: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case errors
    }
    
}

extension PhotosError: Error {
    public var localizedDescription: String {
        return "\(statusCode) " + (errors.first ?? "Unknow error")
    }
}
