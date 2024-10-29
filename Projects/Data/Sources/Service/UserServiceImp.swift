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
    
    public func findAllUser(request: AllUserFindRequest) async -> [UserData] {
        let response = await allUserFindRepository.findAllUser(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(_):
            return []
        }
    }
    
    public func findCategoryUser(request: CategoryUserFindRequest) async -> [UserData] {
        let response = await categoryUserFindRepository.findCategoryUser(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(_):
            return []
        }
    }
    
    public func getUserDetailData(request: UserDetailRequest) async -> UserDetailData? {
        let response = await userDetailRepository.getUserDetailData(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(_):
            return nil
        }
    }
  
    public func updateUserLikeStatus(request: UserLikeRequest) async -> String? {
        let response = await userLikeRepository.updateUserLikeStatus(request: request)
      
        switch response {
        case .success(let response):
            return response.data
        case .failure(_):
            return nil
        }
    }
    
    public func cancelUserLikeStatus(request: UserLikeRequest) async -> String? {
        let response = await userLikeCancelRepository.cancelUserLikeStatus(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(_):
            return nil
        }
    }
}
