//
//  MyPageDTO.swift
//  Data
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

struct MyPageDTO: Decodable {
    public let status: String
    public let data: MyPageData
    public let message: String
}

struct MyPageData: Decodable {
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
}

extension MyPageDTO {
    func toDomain() -> MyPageResponse {
        .init(
            id: data.id,
            notificationToken: data.notificationToken,
            profileImages: data.profileImages,
            likeCount: data.likeCount,
            nickName: data.nickName,
            uniqueId: data.uniqueId,
            birthDay: data.birthDay,
            location: data.location,
            schoolName: data.schoolName,
            mbti: data.mbti,
            introduce: data.introduce,
            snsLinks: data.snsLinks,
            category: data.category,
            questions: data.questions
        )
    }
}
