//
//  SignInRepository.swift
//  Domain
//
//  Created by 최동호 on 6/29/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol SignInRepository {
    func signIn(
        request: LogInRequest,
        completion: @escaping (Result<LogInResponse, Error>) -> Void
    )
}
