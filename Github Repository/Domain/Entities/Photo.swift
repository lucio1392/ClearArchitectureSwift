//
//  Photo.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

public struct Photo: Decodable {
    
    public let id: String
    public let createdAt: String?
    public let updatedAt: String?
    public let photoAttribute: PhotoAttribute
    public let description: String?
    public let altDescription: String?
    public let photoSource: PhotoSource
    public let likesNumber: Int
    public let likedByUser: Bool
    public let user: User
    
    public init(_ id: String,
                createdAt: String?,
                updatedAt: String?,
                photoAttribute: PhotoAttribute,
                description: String?,
                altDescription: String?,
                photoSource: PhotoSource,
                likesNumber: Int = 0,
                likedByUser: Bool = false,
                user: User) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.photoAttribute = photoAttribute
        self.description = description
        self.altDescription = altDescription
        self.photoSource = photoSource
        self.likesNumber = likesNumber
        self.likedByUser = likedByUser
        self.user = user
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case description
        case altDescription = "alt_description"
        case likesNumber = "likes"
        case likedByUser = "liked_by_user"
        case photoSource = "urls"
        case user
    }
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.altDescription = try container.decodeIfPresent(String.self, forKey: .altDescription)
        self.likesNumber = try container.decode(Int.self, forKey: .likesNumber)
        self.likedByUser = try container.decode(Bool.self, forKey: .likedByUser)
        self.photoAttribute = try PhotoAttribute(from: decoder)
        self.photoSource = try container.decode(PhotoSource.self, forKey: .photoSource)
        self.user = try container.decode(User.self, forKey: .user)
    }
}

extension Photo: Equatable {
    public static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}
