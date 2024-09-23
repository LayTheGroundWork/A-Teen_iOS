//
//  VerificateServiceImp.swift
//  Data
//
//  Created by 최동호 on 6/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct VerificateServiceImp: VerificateService {
    private let requestCodeRepository: RequestCodeRepository
    private let verificateCodeRepository: VerificateCodeRepository
    
    public init(
        requestCodeRepository: RequestCodeRepository,
        verificateCodeRepository: VerificateCodeRepository
    ) {
        self.requestCodeRepository = requestCodeRepository
        self.verificateCodeRepository = verificateCodeRepository
    }
    
    public func requestCode(
        request: VerificationCodeRequest,
        completion: @escaping () -> Void
    ) {
        requestCodeRepository.requestCode(request: request, completion: completion)
    }
    
    public func verificateCode(
        request: PhoneNumberAuthRequest,
        completion: @escaping (Result<VerificationCodeResponse, Error>) -> Void
    ) {
        verificateCodeRepository.verificateCode(request: request, completion: completion)
    }
}
