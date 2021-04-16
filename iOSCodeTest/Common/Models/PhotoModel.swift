//
//  PhotoModel.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/16.
//

import Foundation

struct PhotoModel: Codable {
    let id: String
    let created_at: String
    let updated_at: String
    let width: UInt32
    let height: UInt32
    let color: String
    let blur_hash: String
    let likes: UInt32
    let liked_by_user: Bool
    let description: String?
    let urls:PhotoUrlModel
    let user: UserModel
    let sponsorship: Sponsorship?
}

struct PhotoUrlModel: Codable {
    let full: String?
    let raw: String?
    let regular: String?
    let small: String?
    let thumb: String?
}
