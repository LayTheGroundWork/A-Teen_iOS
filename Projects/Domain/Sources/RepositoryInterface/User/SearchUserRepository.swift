//
//  SearchUserRepository.swift
//  Domain
//
//  Created by 노주영 on 1/3/25.
//  Copyright © 2025 ATeen. All rights reserved.
//

import Foundation

public protocol SearchUserRepository {
    func searchUserList(request: SearchUserRequest) async -> Result<SearchUserResponse, Error>
}
