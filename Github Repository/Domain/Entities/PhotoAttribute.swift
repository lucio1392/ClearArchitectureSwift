//
//  PhotoSize.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

public struct PhotoAttribute: Codable {
    
    public let width: Double?
    public let height: Double?
    public let mainColor: String?
    
    public var ratio: Double? {
        return (width ?? 0.0) / (height ?? 0.0)
    }
    
    private enum CodingKeys: String, CodingKey {
        case width
        case height
        case mainColor = "color"
    }
    
}
