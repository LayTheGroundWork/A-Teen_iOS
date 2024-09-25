//
//  RequestCodeRepository.swift
//  Domain
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

public protocol RequestCodeRepository {
    func requestCode(
        request: VerificationCodeRequest,
        completion: @escaping () -> Void
    )
}
