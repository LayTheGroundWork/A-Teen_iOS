//
//  SignService.swift
//  Domain
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol SignService {
    func signIn(request: LogInRequest) async -> (HTTPURLResponse, DefaultResponse)?
    
    func signUp(request: SignUpRequest) async -> (HTTPURLResponse, DefaultResponse)?
    
    func requestCode(request: VerificationCodeRequest) async
    
    func verifyCode(request: PhoneNumberAuthRequest) async -> String?
    
    func duplicationCheck(request: DuplicationCheckRequest) async -> Bool
}
