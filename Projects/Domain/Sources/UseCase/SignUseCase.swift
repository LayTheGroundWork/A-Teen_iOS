//
//  SignUseCase.swift
//  Domain
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//


import Foundation

public protocol SignUseCase {
    func signIn(
        request: LogInRequest,
        completion: @escaping (Result<LogInResponse, Error>) -> Void
    )
    func signUp(
        request: SignUpRequest,
        completion: @escaping (Result<LogInResponse, Error>) -> Void
    )
    func requestCode(
        request: VerificationCodeRequest,
        completion: @escaping () -> Void
    )
    func verificateCode(
        request: PhoneNumberAuthRequest,
        completion: @escaping (String?) -> Void
    )
    
    func searchSchool(
        request: SchoolDataRequest,
        completion: @escaping ([SchoolData]) -> Void
    )
    
    func duplicationCheck(
        request: DuplicationCheckRequest,
        completion: @escaping (Bool) -> Void
    )
}

