//
//  UserUseCase.swift
//  Domain
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

public protocol UserUseCase {
    func findAllUser(
        request: AllUserFindRequest,
        completion: @escaping ([UserData]) -> Void
    )
    
    func findCategoryUser(
        request: CategoryUserFindRequest,
        completion: @escaping ([UserData]) -> Void
    )
    
    func getUserDetailData(
        request: UserDetailRequest,
        completion: @escaping (UserDetailData) -> Void
    )
    
    func updateUserLikeStatus(
        request: UserLikeRequest,
        completion: @escaping (String?) -> Void
    )
    
    func cancelUserLikeStatus(
        request: UserLikeRequest,
        completion: @escaping (String?) -> Void
    )
}
