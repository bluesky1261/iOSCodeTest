//
//  UserModel.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/16.
//

import Foundation

struct UserModel: Codable {
    let id: String
    let username: String
    let name: String
    let portfolio_url: String?
    let bio: String?
    let location: String?
    let total_likes: UInt32
    let total_photos: UInt32
    let total_collections: UInt32
    let instagram_username: String?
    let twitter_username: String?
    let profile_image: UserProfileImage
}

struct UserProfileImage: Codable {
    let small: String?
    let medium: String?
    let large: String?
}

struct Sponsorship: Codable {
    let sponsor: UserModel
    let tagline: String?
    let tagline_url: String?
}
