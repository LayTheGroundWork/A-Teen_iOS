//
//  PhoneNumberViewModel.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import Core
import Common
import Combine
import Domain

public final class PhoneNumberViewModel {
    @Injected(Auth.self)
    public var auth: Auth
    
    @Injected(SignUseCase.self)
    public var useCase: SignUseCase
    
    public var signType: SignType = .signUp

    public var phoneNumber: String = .empty
    
    public var verificationCode: String = .empty

    var state = PassthroughSubject<StateController, Never>()
    
    func requestCode(completion: @escaping () -> Void) {
        useCase.requestCode(
            request: VerificationCodeRequest(phoneNumber: self.phoneNumber)
        ) {
            completion()
        }
    }
    
    func verificationCode(completion: @escaping (String?) -> Void) {
        useCase.verificareCode(
            request: .init(phoneNumber: phoneNumber, verificationCode: verificationCode),
            completion: completion)
    }
    
    func signIn() {
        useCase.signIn(
            request: .init(
                phoneNumber: phoneNumber,
                verificationCode: verificationCode
            )
        ) { result in
            switch result {
            case .success(let tokenData):
                self.auth.setAccessToken(tokenData.authToken)
                self.auth.setRefreshToken(tokenData.refreshToken)
                self.auth.logIn()
                self.state.send(.success)
            case .failure(let error):
                self.state.send(.fail(error: error.localizedDescription))
            }
        }
        
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
