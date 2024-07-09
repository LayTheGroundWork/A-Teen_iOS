//
//  PhoneNumberViewModel.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import Core
import Common
import Domain

public final class PhoneNumberViewModel {
    @Injected(SignUseCase.self)
    public var useCase: SignUseCase
    
    public var signType: SignType = .signUp

    public var phoneNumber: String = ""
    
    public var verificationCode: String = ""

    func requestCode(completion: @escaping () -> Void) {
        useCase.requestCode(
            request: VerificationCodeRequest(phoneNumber: self.phoneNumber)
        ) {
            completion()
        }
    }
    
    func verificationCode(completion: @escaping () -> Void) {
        useCase.verificateCode(request: PhoneNumberAuthRequest(
            phoneNumber: phoneNumber,
            verificationCode: verificationCode)) {
            completion()
        }
    }
    
    func signIn() {
        /*
         useCase.signIn(request: <#T##LogInRequest#>) { <#Result<LogInResponse, Error>#> in
            <#code#>
        }
        */
    }
    
    func changeSignType(signType: SignType) {
        switch signType {
        case .signIn:
            self.signType = .signIn
        case .signUp:
            self.signType = .signUp
        }
    }
    
}
