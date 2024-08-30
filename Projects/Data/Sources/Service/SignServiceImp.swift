//
//  SignServiceImp.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct SignServiceImp: SignService {
    private let duplicationCheckRepository: DuplictaionCheckRepository
    private let signRepository: SignRepository
    private let verificateRepository: VerificateRepository
    
    public init(
        duplicationCheckRepository: DuplictaionCheckRepository,
        signRepository: SignRepository,
        verificateRepository: VerificateRepository
    ) {
        self.duplicationCheckRepository = duplicationCheckRepository
        self.signRepository = signRepository
        self.verificateRepository = verificateRepository
    }
    
    public func signIn(
        request: LogInRequest,
        completion: @escaping (Result<LogInResponse, Error>) -> Void
    ) {
        signRepository.signIn(request: request, completion: completion)
    }
    
    public func signUp(
        request: SignUpRequest,
        completion: @escaping (Result<LogInResponse, Error>) -> Void
    ) {
        signRepository.signUp(request: request, completion: completion)
    }
    
    public func requestCode(
        request: VerificationCodeRequest,
        completion: @escaping () -> Void
    ) {
        verificateRepository.requestCode(request: request, completion: completion)
    }
    
    public func verificateCode(
        request: PhoneNumberAuthRequest,
        completion: @escaping (String?) -> Void
    ) {
        verificateRepository.verificateCode(request: request) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion("")
            }
        }
    }
    
    public func duplicationCheck(
        request: DuplicationCheckRequest,
        completion: @escaping (Bool) -> Void
    ) {
        duplicationCheckRepository.duplicationCheck(request: request) { result in
            switch result {
            case .success(_):
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
