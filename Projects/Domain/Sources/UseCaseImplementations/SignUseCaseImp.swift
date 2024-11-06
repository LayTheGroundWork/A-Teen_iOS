//
//  SignUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Combine
import Common
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
    
    public func signIn(request: LogInRequest) -> AnyPublisher<(HTTPURLResponse, DefaultResponse)?, Never> {
        Future { promise in
            Task {
                let response = await signService.signIn(request: request)
                promise(.success(response))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func signUp(request: SignUpRequest) -> AnyPublisher<(HTTPURLResponse, DefaultResponse)?, Never> {
        Future { promise in
            Task {
                let response = await signService.signUp(request: request)
                promise(.success(response))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func requestCode(request: VerificationCodeRequest) -> AnyPublisher<Void, Never> {
        Future { promise in
            Task {
                await signService.requestCode(request: request)
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func verifyCode(request: PhoneNumberAuthRequest) -> AnyPublisher<String?, Never> {
        Future { promise in
            Task {
                let code = await signService.verifyCode(request: request)
                promise(.success(code))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func searchSchool(request: SchoolDataRequest) -> AnyPublisher<[SchoolData], Never> {
        Future { promise in
            Task {
                let schools = await searchService.searchSchool(request: request)
                print("여기 \(schools)")
                promise(.success(schools))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func duplicationCheck(request: DuplicationCheckRequest) -> AnyPublisher<Bool, Never> {
        Future { promise in
            Task {
                let isDuplicate = await signService.duplicationCheck(request: request)
                promise(.success(isDuplicate))
            }
        }
        .eraseToAnyPublisher()
    }
}

