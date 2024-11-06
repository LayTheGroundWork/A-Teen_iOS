//
//  SignUseCase.swift
//  Domain
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Combine
import Common
import Foundation

public protocol SignUseCase {
    func signIn(request: LogInRequest) -> AnyPublisher<(HTTPURLResponse, DefaultResponse)?, Never>
    func signUp(request: SignUpRequest) -> AnyPublisher<(HTTPURLResponse, DefaultResponse)?, Never>
    func requestCode(request: VerificationCodeRequest) -> AnyPublisher<Void, Never>
    func verifyCode(request: PhoneNumberAuthRequest) -> AnyPublisher<String?, Never>
    func searchSchool(request: SchoolDataRequest) -> AnyPublisher<[SchoolData], Never>
    func duplicationCheck(request: DuplicationCheckRequest) -> AnyPublisher<Bool, Never>
}
