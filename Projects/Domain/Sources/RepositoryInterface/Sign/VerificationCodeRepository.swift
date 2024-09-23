//
//  VerificationCodeRepository.swift
//  Domain
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

public protocol VerificationCodeRepository {
    func verificareCode(
        request: PhoneNumberAuthRequest,
        completion: @escaping (Result<DefaultResponse, Error>) -> Void
    )
}

