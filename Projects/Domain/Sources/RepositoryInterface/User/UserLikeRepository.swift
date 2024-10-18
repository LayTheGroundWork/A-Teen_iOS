//
//  UserLikeRepository.swift
//  Domain
//
//  Created by 노주영 on 10/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol UserLikeRepository {
    func updateUserLikeStatus(
        request: UserLikeRequest,
        completion: @escaping (Result<DefaultResponse, Error>) -> Void
    )
}
