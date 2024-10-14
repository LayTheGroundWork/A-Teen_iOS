//
//  MyPageEditRequest.swift
//  Domain
//
//  Created by 노주영 on 10/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct MyPageEditRequest {
    public let authorization: String
    
    public let nickName: String
    public let schoolData: SchoolData
    public let snsPlatform: SnsLinkData?
    public let mbti: String?
    public let introduction: String?
    public let questions: [QuestionData]

    public init(
        authorization: String,
        nickName: String,
        schoolData: SchoolData,
        snsPlatform: SnsLinkData?,
        mbti: String?,
        introduction: String?,
        questions: [QuestionData]
    ) {
        self.authorization = authorization
        self.nickName = nickName
        self.schoolData = schoolData
        self.snsPlatform = snsPlatform
        self.mbti = mbti
        self.introduction = introduction
        self.questions = questions
    }
}
