//
//  SignUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct SignUseCaseImp: SignUseCase {
    private let signService: SignService
    private let verificateService: VerificateService
 
    public init(
        signService: SignService,
        verificateService: VerificateService
    ) {
        self.signService = signService
        self.verificateService = verificateService
    }
    
    public func signIn(
        request: LogInRequest,
        completion: @escaping (Result<LogInResponse, Error>) -> Void
    ) {
        signService.signIn(request: request, completion: completion)
    }
    
    public func signUp(
        request: SignUpRequest,
        completion: @escaping (Result<LogInResponse, Error>) -> Void
    ) {
        signService.signUp(request: request, completion: completion)
    }
    
    public func requestCode(
        request: VerificationCodeRequest,
        completion: @escaping () -> Void
    ) {
        verificateService.requestCode(request: request, completion: completion)
    }
    
    public func verificateCode(
        request: PhoneNumberAuthRequest,
        completion: @escaping (Result<VerificationCodeResponse, Error>) -> Void
    ) {
        verificateService.verificateCode(request: request, completion: completion)
    }
   
}
