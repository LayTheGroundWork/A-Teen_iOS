//
//  UserService.swift
//  Domain
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol UserService {
    func findAllUser(request: AllUserFindRequest) async -> UserData
    func findCategoryUser(request: CategoryUserFindRequest) async -> UserData
    func getUserDetailData(request: UserDetailRequest) async -> UserDetailData?
    func updateUserLikeStatus(request: UserLikeRequest) async -> String?
    func cancelUserLikeStatus(request: UserLikeRequest) async -> String?
}
