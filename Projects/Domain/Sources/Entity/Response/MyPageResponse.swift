//
//  MyPageResponse.swift
//  Domain
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct MyPageResponse: Decodable {
    public let id: Int
    public let profileImages: [String]
    public let likeCount: Int
    public let nickName: String
    public let uniqueId: String
    public let birthDay: String
    public let location: String
    public let schoolName: String
    public let snsLinks: [String]
    public let category: String
    public let question: [String: String]
    
    public init(
        id: Int,
        profileImages: [String],
        likeCount: Int,
        nickName: String,
        uniqueId: String,
        birthDay: String,
        location: String,
        schoolName: String,
        snsLinks: [String],
        category: String,
        question: [String : String]
    ) {
        self.id = id
        self.profileImages = profileImages
        self.likeCount = likeCount
        self.nickName = nickName
        self.uniqueId = uniqueId
        self.birthDay = birthDay
        self.location = location
        self.schoolName = schoolName
        self.snsLinks = snsLinks
        self.category = category
        self.question = question
    }
}
