//
//  MyPageResponse.swift
//  Domain
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct MyPageResponse: Decodable {
    public let data: MyPageData?
    
    public init(data: MyPageData?) {
        self.data = data
    }
}

public struct MyPageData: Decodable {
    public let id: Int
    public let profileImages: [String]
    public let likeCount: Int
    public let nickName: String
    public let uniqueId: String
    public var mbti: String?
    public var introduction: String?
    public let birthDay: String
    public let location: String
    public let schoolName: String
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

public struct SnsLinkData: Codable {
    public var instagram: String
    public var x: String
    public var tiktok: String
    public var youtube: String
    
    public init(
        instagram: String,
        x: String,
        tiktok: String,
        youtube: String
    ) {
        self.instagram = instagram
        self.x = x
        self.tiktok = tiktok
        self.youtube = youtube
    }
}

public struct QuestionData: Codable, Equatable {
    public var question: String
    public var answer: String
    
    public init(
        question: String,
        answer: String
    ) {
        self.question = question
        self.answer = answer
    }
}
