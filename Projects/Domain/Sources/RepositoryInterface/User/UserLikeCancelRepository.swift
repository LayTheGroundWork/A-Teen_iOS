//
//  UserLikeCancelRepository.swift
//  Domain
//
//  Created by 노주영 on 10/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol UserLikeCancelRepository {
    func cancelUserLikeStatus(
        request: UserLikeRequest,
        completion: @escaping (Result<DefaultResponse, Error>) -> Void
    )
}
