//
//  VerificateRepository.swift
//  Domain
//
//  Created by 최동호 on 6/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol VerificateRepository {
    func requestCode(
        request: VerificationCodeRequest,
        completion: @escaping () -> Void
    )
    func verificateCode(
        request: PhoneNumberAuthRequest,
        completion: @escaping (Result<VerificationCodeResponse, Error>) -> Void
    )
}
