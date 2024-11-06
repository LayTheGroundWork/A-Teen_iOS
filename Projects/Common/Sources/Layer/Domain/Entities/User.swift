//
//  User.swift
//  Common
//
//  Created by 최동호 on 11/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct User: Decodable {
    public let id: Int
    public let uniqueId: String
    public let profileImage: String?
    public let nickName: String
    public let location: String
    public let schoolName: String
    public var likeStatus: Bool
    
    public init(
        id: Int,
        uniqueId: String,
        profileImage: String?,
        nickName: String,
        location: String,
        schoolName: String,
        likeStatus: Bool
    ) {
        self.id = id
        self.uniqueId = uniqueId
        self.profileImage = profileImage
        self.nickName = nickName
        self.location = location
        self.schoolName = schoolName
        self.likeStatus = likeStatus
    }
}
