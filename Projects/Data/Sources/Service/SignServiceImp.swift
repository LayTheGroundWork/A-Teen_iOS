//
//  SignServiceImp.swift
//  Data
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct SignServiceImp: SignService {
    private let signInRepository: SignInRepository
    private let signUpRepository: SignUpRepository
    
    public init(
        signInRepository: SignInRepository,
        signUpRepository: SignUpRepository
    ) {
        self.signInRepository = signInRepository
        self.signUpRepository = signUpRepository
    }
    
    public func signIn(request: LogInRequest, completion: @escaping (Result<LogInResponse, Error>) -> Void) {
        signInRepository.signIn(request: request, completion: completion)
    }
    
    public func signUp(request: SignUpRequest, completion: @escaping (Result<LogInResponse, Error>) -> Void) {
        signUpRepository.signUp(request: request, completion: completion)
    }
}
