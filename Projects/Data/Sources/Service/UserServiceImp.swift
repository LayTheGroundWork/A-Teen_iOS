//
//  UserServiceImp.swift
//  Data
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct UserServiceImp: UserService {
    private let allUserFindRepository: AllUserFindRepository
    private let categoryUserFindRepository: CategoryUserFindRepository
    private let userDetailRepository: UserDetailRepository
    private let userLikeRepository: UserLikeRepository
    private let userLikeCancelRepository: UserLikeCancelRepository
    
    public init(
        allUserFindRepository: AllUserFindRepository,
        categoryUserFindRepository: CategoryUserFindRepository,
        userDetailRepository: UserDetailRepository,
        userLikeRepository: UserLikeRepository,
        userLikeCancelRepository: UserLikeCancelRepository
    ) {
        self.allUserFindRepository = allUserFindRepository
        self.categoryUserFindRepository = categoryUserFindRepository
        self.userDetailRepository = userDetailRepository
        self.userLikeRepository = userLikeRepository
        self.userLikeCancelRepository = userLikeCancelRepository
    }
    
    public func findAllUser(
        request: AllUserFindRequest,
        completion: @escaping ([UserData]) -> Void
    ) {
        allUserFindRepository.findAllUser(request: request) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    public func findCategoryUser(
        request: CategoryUserFindRequest,
        completion: @escaping ([UserData]) -> Void
    ) {
        categoryUserFindRepository.findCategoryUser(request: request) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    public func getUserDetailData(
        request: UserDetailRequest,
        completion: @escaping (UserDetailData) -> Void
    ) {
        userDetailRepository.getUserDetailData(request: request) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion(.init(
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
                    questions: []))
            }
        }
    }
    
    public func updateUserLikeStatus(
        request: UserLikeRequest,
        completion: @escaping (String?) -> Void
    ) {
        userLikeRepository.updateUserLikeStatus(request: request) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    public func cancelUserLikeStatus(
        request: UserLikeRequest,
        completion: @escaping (String?) -> Void
    ) {
        userLikeCancelRepository.cancelUserLikeStatus(request: request) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
