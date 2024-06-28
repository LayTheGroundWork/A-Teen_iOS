//
//  DefaultSignRepository.swift
//  Data
//
//  Created by 최동호 on 6/29/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService

import Foundation

public final class DefaultSignRepository: NSObject, SignRepository {
    private let apiClientService: ApiClientService
    
    public init(
        apiClientService: ApiClientService
    ) {
        self.apiClientService = apiClientService
    }
    
    public func signIn(
        request: Domain.LogInRequest,
        completion: @escaping (Result<Domain.LogInResponse, Error>) -> Void
    ) {
        print("로그인 로직")
    }
    
    public func signUp(
        request: Domain.SignUpRequest,
        completion: @escaping (Result<Domain.LogInResponse, Error>) -> Void
    ) {
        print("회원가입 로직")

    }
    
    public func requestCode(
        request: Domain.VerificationCodeRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        print("인증코드 요청 로직")

    }
    
    public func verificateCode(
        request: Domain.PhoneNumberAuthRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        print("인증번호 확인 로직")

    }
    
    
}
