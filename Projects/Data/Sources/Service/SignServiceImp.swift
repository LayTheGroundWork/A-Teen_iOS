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
    
    public func signIn(
        request: LogInRequest,
        completion: @escaping (LogInData?) -> Void
    ) {
        signInRepository.signIn(request: request) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    public func signUp(
        request: SignUpRequest,
        completion: @escaping (LogInData?) -> Void
    ) {
        signUpRepository.signUp(request: request) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    public func requestCode(
        request: VerificationCodeRequest,
        completion: @escaping () -> Void
    ) {
        requestCodeRepository.requestCode(request: request, completion: completion)
    }
    
    public func verificareCode(
        request: PhoneNumberAuthRequest,
        completion: @escaping (String?) -> Void
    ) {
        verificationCodeRepository.verificareCode(request: request) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    public func duplicationCheck(
        request: DuplicationCheckRequest,
        completion: @escaping (Bool) -> Void
    ) {
        duplicationCheckRepository.duplicationCheck(request: request) { result in
            switch result {
            case .success(let response):
                completion(!response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
