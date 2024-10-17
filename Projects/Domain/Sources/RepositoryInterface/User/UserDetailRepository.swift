//
//  UserDetailRepository.swift
//  Domain
//
//  Created by 노주영 on 10/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol UserDetailRepository {
    func getUserDetailData(
        request: UserDetailRequest,
        completion: @escaping (Result<UserDetailResponse, Error>) -> Void
    )
}
