//
//  SignUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct SignUseCaseImp: SignUseCase {

    private let repository: SignRepository
    public let service: VerificateService
 
    public init(
        repository: SignRepository,
        service: VerificateService
    ) {
        self.repository = repository
        self.service = service
    }
    
    public func signIn(
        request: LogInRequest,
        completion: @escaping (Result<LogInResponse, Error>) -> Void
    ) {
        repository.signIn(request: request, completion: completion)
    }
    
    public func signUp(
        request: SignUpRequest,
        completion: @escaping (Result<LogInResponse, Error>) -> Void
    ) {
        repository.signUp(request: request, completion: completion)
    }
    
    public func requestCode(
        request: VerificationCodeRequest,
        completion: @escaping () -> Void
    ) {
        service.requestCode(request: request, completion: completion)
    }
    
    public func verificateCode(
        request: PhoneNumberAuthRequest,
        completion: @escaping (Result<VerificationCodeResponse, Error>) -> Void
    ) {
        service.verificateCode(request: request, completion: completion)
    }
   
}
