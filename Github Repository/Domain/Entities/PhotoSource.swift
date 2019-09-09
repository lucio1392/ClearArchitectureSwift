//
//  PhotoSource.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

public struct PhotoSource: Decodable {
    
    public let small: String?
    public let thumb: String?
    public let regular: String?
    public let raw: String?
    public let full: String?
    
    private enum CodingKeys: String, CodingKey {
        case small
        case regular
        case thumb
        case raw
        case full
    }
    
}
