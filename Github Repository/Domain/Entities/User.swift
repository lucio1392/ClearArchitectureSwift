//
//  User.swift
//  Github Repository
//
//  Created by Macbook on 9/6/19.
//  Copyright © 2019 Macbook. All rights reserved.
//

import Foundation

public struct User: Decodable {
    
    public let id: String
    public let updatedAt: String?
    public let username: String?
    public let name: String?
    public let firstName: String?
    public let lastName: String?
    public let twitterUserName: String?
    public let portfolio: String?
    public let bio: String?
    public let location: String?
    public let profileImage: UserProfileSource
    
    private enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolio = "portfolio_url"
        case bio
        case location
        case profileImage = "profile_image"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.twitterUserName = try container.decodeIfPresent(String.self, forKey: .twitterUsername)
        self.portfolio = try container.decodeIfPresent(String.self, forKey: .portfolio)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.profileImage = try container.decode(UserProfileSource.self, forKey: .profileImage)
    }
}
