//
//  MyPageResponse.swift
//  Domain
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct MyPageResponse: Decodable {
    let id: Int
    let notificationToken: String
    let profileImages: [String]
    let likeCount: Int
    let nickName: String
    let uniqueId: String
    let birthDay: String
    let location: String
    let schoolName: String
    let mbti: String
    let introduce: String
    let snsLinks: [SnsLinkData]
    let category: String
    let questions: [QuestionData]
    
    public init(
        id: Int,
        notificationToken: String,
        profileImages: [String],
        likeCount: Int,
        nickName: String,
        uniqueId: String,
        birthDay: String,
        location: String,
        schoolName: String,
        mbti: String,
        introduce: String,
        snsLinks: [SnsLinkData],
        category: String,
        questions: [QuestionData]
    ) {
        self.id = id
        self.notificationToken = notificationToken
        self.profileImages = profileImages
        self.likeCount = likeCount
        self.nickName = nickName
        self.uniqueId = uniqueId
        self.birthDay = birthDay
        self.location = location
        self.schoolName = schoolName
        self.mbti = mbti
        self.introduce = introduce
        self.snsLinks = snsLinks
        self.category = category
        self.questions = questions
    }
}

public struct SnsLinkData: Decodable {
    let snsName: String
    let snsId: String
}

public struct QuestionData: Decodable{
    let title: String
    let answer: String
}
