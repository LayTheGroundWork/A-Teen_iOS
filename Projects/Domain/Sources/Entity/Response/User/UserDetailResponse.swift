//
//  UserDetailResponse.swift
//  Domain
//
//  Created by 노주영 on 10/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct UserDetailResponse: Decodable {
    public let data: UserDetailData
    
    public init(data: UserDetailData) {
        self.data = data
    }
}

public struct UserDetailData: Decodable {
    public let id: Int
    public let profileImages: [String]
    public let likeCount: Int
    public var nickName: String
    public let uniqueId: String
    public var mbti: String?
    public var introduction: String?
    public let birthDay: String
    public var location: String
    public var schoolName: String
    public var snsPlatform: SnsLinkData?
    public let category: String
    public var questions: [QuestionData]
    
    public init(
        id: Int,
        profileImages: [String],
        likeCount: Int,
        nickName: String,
        uniqueId: String,
        mbti: String?,
        introduction: String?,
        birthDay: String,
        location: String,
        schoolName: String,
        snsPlatform: SnsLinkData?,
        category: String,
        questions: [QuestionData]
    ) {
        self.id = id
        self.profileImages = profileImages
        self.likeCount = likeCount
        self.nickName = nickName
        self.uniqueId = uniqueId
        self.mbti = mbti
        self.introduction = introduction
        self.birthDay = birthDay
        self.location = location
        self.schoolName = schoolName
        self.snsPlatform = snsPlatform
        self.category = category
        self.questions = questions
    }
}
