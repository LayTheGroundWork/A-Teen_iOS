//
//  ProfileDetailViewModel.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

import Core
import Domain
import UIKit

public class ProfileDetailViewModel {
    @Injected(Auth.self)
    public var auth: Auth
    
    @Injected(UserUseCase.self)
    public var userUseCase: UserUseCase
    
    public let uniqueId: String
    
    public var todayTeenImages: [UIImage]
    public var user: UserDetailData = .init(
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
        category: "스포츠",
        questions: [])
    
    public init(
        uniqueId: String,
        todayTeenImages: [UIImage]
    ) {
        self.uniqueId = uniqueId
        self.todayTeenImages = todayTeenImages
    }
}

extension ProfileDetailViewModel {
    func getUserAge() -> Int {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        guard let currentYear = Int(dateFormatter.string(from: currentDate)),
              let birthYearString = user.birthDay.components(separatedBy: "-").first,
              let birthYear = Int(birthYearString)
        else { return 0 }
        
        return currentYear - birthYear + 1
    }
    
    func getUserDetailData(completion: @escaping () -> Void) {
        guard let token = auth.getAccessToken(),
              auth.isSessionActive      //앱 팅겨서 임시로 넣어놓음
        else {
            completion()
            return
        }
        
        userUseCase.getUserDetailData(request: .init(authorization: token, uniqueId: uniqueId)) { user in
            self.user = user
            completion()
        }
    }
}
