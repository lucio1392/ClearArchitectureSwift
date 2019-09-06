//
//  Photo.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation


//"id": "cPL3v742q3E",
//"created_at": "2019-07-03T16:11:16-04:00",
//"updated_at": "2019-08-28T01:06:56-04:00",
//"width": 4480,
//"height": 6720,
//"color": "#E0C19C",
//"description": "Everything you need to focus, all at your fingertips.",
//"alt_description": "man writing on notebook on wooden desk and coffee place on the wall",
//"urls": {
//    "raw": "https://images.unsplash.com/photo-1562184647-650768414b91?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjMyNzV9",
//    "full": "https://images.unsplash.com/photo-1562184647-650768414b91?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjMyNzV9",
//    "regular": "https://images.unsplash.com/photo-1562184647-650768414b91?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjMyNzV9",
//    "small": "https://images.unsplash.com/photo-1562184647-650768414b91?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjMyNzV9",
//    "thumb": "https://images.unsplash.com/photo-1562184647-650768414b91?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjMyNzV9"
//},
//"links": {
//    "self": "https://api.unsplash.com/photos/cPL3v742q3E",
//    "html": "https://unsplash.com/photos/cPL3v742q3E",
//    "download": "https://unsplash.com/photos/cPL3v742q3E/download",
//    "download_location": "https://api.unsplash.com/photos/cPL3v742q3E/download"
//},
//"categories": [],
//"likes": 146,
//"liked_by_user": false,
//"current_user_collections": [],
//"user": {
//    "id": "WuY-vaNpJXk",
//    "updated_at": "2019-09-05T20:33:54-04:00",
//    "username": "room",
//    "name": "ROOM",
//    "first_name": "ROOM",
//    "last_name": "",
//    "twitter_username": "roomnyc",
//    "portfolio_url": "https://getroom.com/",
//    "bio": "A tech startup designing creative solutions for the modern office. All about office interior design, commercial architecture inspiration, and more.",
//    "location": "NYC",
//    "links": {
//        "self": "https://api.unsplash.com/users/room",
//        "html": "https://unsplash.com/@room",
//        "photos": "https://api.unsplash.com/users/room/photos",
//        "likes": "https://api.unsplash.com/users/room/likes",
//        "portfolio": "https://api.unsplash.com/users/room/portfolio",
//        "following": "https://api.unsplash.com/users/room/following",
//        "followers": "https://api.unsplash.com/users/room/followers"
//    },
//    "profile_image": {
//        "small": "https://images.unsplash.com/profile-1557323724887-db0c1f8a5cb8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32",
//        "medium": "https://images.unsplash.com/profile-1557323724887-db0c1f8a5cb8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64",
//        "large": "https://images.unsplash.com/profile-1557323724887-db0c1f8a5cb8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128"
//    },
//    "instagram_username": "roomnyc",
//    "total_collections": 0,
//    "total_likes": 0,
//    "total_photos": 35,
//    "accepted_tos": true
//},


public struct Photo: Codable {
    
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
    
    public func encode(to encoder: Encoder) throws {
        
    }
}

extension Photo: Equatable {
    public static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}
