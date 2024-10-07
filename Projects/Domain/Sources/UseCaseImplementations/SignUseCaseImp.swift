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
    private let searchService: SearchSchoolService
    
    public init(
        signService: SignService,
        searchService: SearchSchoolService
    ) {
        self.signService = signService
        self.searchService = searchService
    }
    
    public func signIn(
        request: LogInRequest,
        completion: @escaping (LogInData?) -> Void
    ) {
        signService.signIn(request: request, completion: completion)
    }
    
    public func signUp(
        request: SignUpRequest,
        completion: @escaping (LogInData?) -> Void
    ) {
        signService.signUp(request: request, completion: completion)
    }
    
    public func requestCode(
        request: VerificationCodeRequest,
        completion: @escaping () -> Void
    ) {
        signService.requestCode(request: request, completion: completion)
    }
    
    public func verificareCode(
        request: PhoneNumberAuthRequest,
        completion: @escaping (String?) -> Void
    ) {
        signService.verificareCode(request: request, completion: completion)
    }
    
    public func searchSchool(
        request: SchoolDataRequest,
        completion: @escaping ([SchoolData]) -> Void
    ) {
        searchService.searchSchool(request: request, completion: completion)
    }
   
    public func duplicationCheck(
        request: DuplicationCheckRequest,
        completion: @escaping (Bool) -> Void
    ) {
        signService.duplicationCheck(request: request, completion: completion)
    }
}
