//
//  SignUpRepository.swift
//  Domain
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol SignUpRepository {
    func signUp(
        request: SignUpRequest,
        completion: @escaping (Result<(HTTPURLResponse, DefaultResponse), Error>) -> Void
    )
}
