//
//  UserService.swift
//  Domain
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Foundation

public protocol UserService {
    func findCategoryTodayTeen(request: CategoryTodayTeenFindRequest) async -> [User]
    func findCategoryUser(request: CategoryUserFindRequest) async -> UserData
    func getUserDetailData(request: UserDetailRequest) async -> UserDetailData?
    func updateUserLikeStatus(request: UserLikeRequest) async -> String?
    func cancelUserLikeStatus(request: UserLikeRequest) async -> String?
    func searchUserList(request: SearchUserRequest) async -> [SearchUserData]
    func getAuthToken() -> String?
}
