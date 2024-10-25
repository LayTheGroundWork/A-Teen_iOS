//
//  ProfileDetailViewModel.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

import Core
import Combine
import Domain
import UIKit

public class ProfileDetailViewModel {
    @Injected(Auth.self)
    public var auth: Auth
    
    @Injected(UserUseCase.self)
    public var userUseCase: UserUseCase
    
    var userLoaded = PassthroughSubject<Void, Never>()
    
    private var cancellables = Set<AnyCancellable>()
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
        questions: []
    )
    
    public let uniqueId: String
    
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
    
    func getUserDetailData() {
        userUseCase.getUserDetailData(request: .init(uniqueId: uniqueId))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userData in
                if let userData = userData {
                    self?.user = userData
                } else {
                    self?.user = UserDetailData(
                        id: 0,
                        profileImages: [],
                        likeCount: 0,
                        nickName: "",
                        uniqueId: "",
                        mbti: nil,
                        introduction: nil,
                        birthDay: "",
                        location: "",
                        schoolName: "",
                        snsPlatform: nil,
                        category: "",
                        questions: []
                    )
                }

                self?.userLoaded.send()
            }
            .store(in: &cancellables)
    }
}
