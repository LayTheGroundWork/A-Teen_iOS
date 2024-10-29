//
//  UserFindResponse.swift
//  Domain
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct UserFindResponse: Decodable {
    public let data: [UserData]
    
    public init(data: [UserData]) {
        self.data = data
    }
}

public struct UserData: Decodable {
    public let id: Int
    public let uniqueId: String
    public let profileImages: String?
    public let nickName: String
    public let location: String
    public let schoolName: String
    public var likeStatus: Bool
    
    public init(
        id: Int,
        uniqueId: String,
        profileImages: String?,
        nickName: String,
        location: String,
        schoolName: String,
        likeStatus: Bool
    ) {
        self.id = id
        self.uniqueId = uniqueId
        self.profileImages = profileImages
        self.nickName = nickName
        self.location = location
        self.schoolName = schoolName
        self.likeStatus = likeStatus
    }
}
