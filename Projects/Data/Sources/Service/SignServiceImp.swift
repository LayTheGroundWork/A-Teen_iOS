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
    private let duplicationCheckRepository: DuplictaionCheckRepository
    private let requestCodeRepository: RequestCodeRepository
    private let verificationCodeRepository: VerificationCodeRepository

    public init(
        signInRepository: SignInRepository,
        signUpRepository: SignUpRepository,
        duplicationCheckRepository: DuplictaionCheckRepository,
        requestCodeRepository: RequestCodeRepository,
        verificationCodeRepository: VerificationCodeRepository
    ) {
        self.signInRepository = signInRepository
        self.signUpRepository = signUpRepository
        self.duplicationCheckRepository = duplicationCheckRepository
        self.requestCodeRepository = requestCodeRepository
        self.verificationCodeRepository = verificationCodeRepository
    }
    
    public func signIn(request: LogInRequest) async -> (HTTPURLResponse, DefaultResponse)? {
        let response = await signInRepository.signIn(request: request)
            
        switch response {
        case .success(let response):
            return response
        case .failure(_):
            return nil
        }
    }
    
    public func signUp(request: SignUpRequest) async -> (HTTPURLResponse, DefaultResponse)? {
        let response = await signUpRepository.signUp(request: request)
        
        switch response {
        case .success(let response):
            return response
        case .failure(_):
            return nil
        }
    }
    
    public func requestCode(request: VerificationCodeRequest) async {
        await requestCodeRepository.requestCode(request: request)
    }
    
    public func verifyCode(request: PhoneNumberAuthRequest) async -> String? {
        let response = await verificationCodeRepository.verifyCode(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(_):
            return nil
        }
    }
    
    public func duplicationCheck(request: DuplicationCheckRequest) async -> Bool {
        let response = await duplicationCheckRepository.duplicationCheck(request: request)
        
        switch response {
        case .success(let response):
            return !response.data
        case .failure(_):
            return true
        }
    }
}
