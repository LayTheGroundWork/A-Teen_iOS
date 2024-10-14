//
//  SignService.swift
//  Domain
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol SignService {
    func signIn(
        request: LogInRequest,
        completion: @escaping ((HTTPURLResponse, DefaultResponse)?) -> Void
    )
    func signUp(
        request: SignUpRequest,
        completion: @escaping ((HTTPURLResponse, DefaultResponse)?) -> Void
    )
    func requestCode(
        request: VerificationCodeRequest,
        completion: @escaping () -> Void
    )
    func verificareCode(
        request: PhoneNumberAuthRequest,
        completion: @escaping (String?) -> Void
    )
    
    func duplicationCheck(
        request: DuplicationCheckRequest,
        completion: @escaping (Bool) -> Void
    )
}
