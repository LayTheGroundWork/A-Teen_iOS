//
//  SignServiceImp.swift
//  Data
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Domain
import Foundation

public struct SignServiceImp: SignService {
    private let auth: Auth
    private let signInRepository: SignInRepository
    private let signUpRepository: SignUpRepository
    private let duplicationCheckRepository: DuplictaionCheckRepository
    private let requestCodeRepository: RequestCodeRepository
    private let verificationCodeRepository: VerificationCodeRepository

    public init(
        auth: Auth,
        signInRepository: SignInRepository,
        signUpRepository: SignUpRepository,
        duplicationCheckRepository: DuplictaionCheckRepository,
        requestCodeRepository: RequestCodeRepository,
        verificationCodeRepository: VerificationCodeRepository
    ) {
        self.auth = auth
        self.signInRepository = signInRepository
        self.signUpRepository = signUpRepository
        self.duplicationCheckRepository = duplicationCheckRepository
        self.requestCodeRepository = requestCodeRepository
        self.verificationCodeRepository = verificationCodeRepository
    }
    
    public func signIn(request: LogInRequest) async -> String? {
        let response = await signInRepository.signIn(request: request)
            
        switch response {
        case .success(let response):
            setTokens(response: response.0)
            return response.1.data
        case .failure(_):
            return nil
        }
    }
    
    public func signUp(request: SignUpRequest) async -> String? {
        let response = await signUpRepository.signUp(request: request)
        
        switch response {
        case .success(let response):
            setTokens(response: response.0)
            return response.1.data
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
    
    public func deleteToken() {
        auth.logOut()
    }
    
    private func setTokens(response: HTTPURLResponse) {
        guard let accessToken = response.value(forHTTPHeaderField: "authorization"),
              let refreshToken = response.value(forHTTPHeaderField: "refresh") else { return }

        auth.setAccessToken(accessToken)
        auth.setRefreshToken(refreshToken)
    }
    
}
