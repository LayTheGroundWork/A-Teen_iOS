//
//  UserUseCase.swift
//  Domain
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Combine

public protocol UserUseCase {
    func findAllUser(request: AllUserFindRequest)  -> AnyPublisher<UserData, Never>
    func findCategoryUser(request: CategoryUserFindRequest) -> AnyPublisher<UserData, Never>
    func getUserDetailData(request: UserDetailRequest) -> AnyPublisher<UserDetailData?, Never>
    func updateUserLikeStatus(request: UserLikeRequest) -> AnyPublisher<String?, Never>
    func cancelUserLikeStatus(request: UserLikeRequest) -> AnyPublisher<String?, Never>
    func getAuthToken() -> String?
}
