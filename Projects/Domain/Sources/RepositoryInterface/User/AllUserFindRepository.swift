//
//  AllUserFindRepository.swift
//  Domain
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol AllUserFindRepository {
    func findAllUser(
        request: AllUserFindRequest,
        completion: @escaping (Result<UserFindResponse, Error>) -> Void
    )
}
