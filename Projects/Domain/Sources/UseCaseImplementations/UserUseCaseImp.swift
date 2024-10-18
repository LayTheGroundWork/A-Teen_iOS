//
//  UserUseCaseImp.swift
//  Domain
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct UserUseCaseImp: UserUseCase {
    public let userService: UserService
    
    public init(userService: UserService) {
        self.userService = userService
    }
    
    public func findAllUser(
        request: AllUserFindRequest,
        completion: @escaping ([UserData]) -> Void
    ) {
        userService.findAllUser(request: request, completion: completion)
    }
    
    public func findCategoryUser(
        request: CategoryUserFindRequest,
        completion: @escaping ([UserData]) -> Void
    ) {
        userService.findCategoryUser(request: request, completion: completion)
    }
    
    public func getUserDetailData(
        request: UserDetailRequest,
        completion: @escaping (UserDetailData) -> Void
    ) {
        userService.getUserDetailData(request: request, completion: completion)
    }
    
    public func updateUserLikeStatus(
        request: UserLikeRequest,
        completion: @escaping (String?) -> Void
    ) {
        userService.updateUserLikeStatus(request: request, completion: completion)
    }
    
    public func cancelUserLikeStatus(
        request: UserLikeRequest,
        completion: @escaping (String?) -> Void
    ) {
        userService.cancelUserLikeStatus(request: request, completion: completion)
    }
}
