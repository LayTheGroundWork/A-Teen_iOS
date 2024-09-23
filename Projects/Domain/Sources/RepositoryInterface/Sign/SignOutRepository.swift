//
//  SignOutRepository.swift
//  Domain
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol SignOutRepository {
    func signOut(
        request: LogOutRequest,
        completion: @escaping (Result<LogOutResponse, Error>) -> Void
    )
}
