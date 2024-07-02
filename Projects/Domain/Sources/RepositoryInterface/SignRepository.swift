//
//  SignRepository.swift
//  Domain
//
//  Created by 최동호 on 6/29/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol SignRepository {
    func signIn(
        request: LogInRequest,
        completion: @escaping (Result<LogInResponse, Error>) -> Void
    )
    func signUp(
        request: SignUpRequest,
        completion: @escaping (Result<LogInResponse, Error>) -> Void
    )
}
