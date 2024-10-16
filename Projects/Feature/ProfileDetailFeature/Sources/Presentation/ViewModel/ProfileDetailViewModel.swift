//
//  ProfileDetailViewModel.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

import Domain
import UIKit

public class ProfileDetailViewModel {
    public let uniqueId: String
    public var todayTeen: MyPageData?
    public var todayTeenImages: [UIImage]
    
    public init(
        uniqueId: String,
        todayTeenImages: [UIImage]
    ) {
        self.uniqueId = uniqueId
        self.todayTeenImages = todayTeenImages
        
        todayTeen = .init(
            id: 0,
            profileImages: [],
            likeCount: 15,
            nickName: "철수",
            uniqueId: "",
            mbti: nil,
            introduction: nil,
            birthDay: "1997-09-01",
            location: "서울",
            schoolName: "서울고등학교",
            snsPlatform: nil,
            category: "",
            questions: [])
    }
}
