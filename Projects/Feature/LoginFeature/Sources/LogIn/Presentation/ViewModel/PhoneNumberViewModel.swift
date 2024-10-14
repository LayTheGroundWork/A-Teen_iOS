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
    
    public var temporaryTokenData: (String, String)?

    var state = PassthroughSubject<StateController, Never>()
}

// MARK: - 인증
extension PhoneNumberViewModel {
    func requestCode(completion: @escaping () -> Void) {
        useCase.requestCode(
            request: VerificationCodeRequest(phoneNumber: self.phoneNumber),
            completion: completion)
    }
    
    func verificationCode(completion: @escaping (Bool) -> Void) {
        print("asd\(auth.isSessionActive)")
        useCase.verificareCode(request: .init(phoneNumber: phoneNumber, verificationCode: verificationCode)) { data in
            if let _ = data {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}

// MARK: - 회원가입 및 로그인
extension PhoneNumberViewModel {
    func changeSignType(signType: SignType) {
        switch signType {
        case .signIn:
            self.signType = .signIn
        case .signUp:
            self.signType = .signUp
        }
    }
    
    func setAuth(
        accessToken: String,
        refreshToken: String,
        completion: () -> Void
    ) {
        self.auth.setAccessToken(accessToken)
        self.auth.setRefreshToken(refreshToken)
        self.auth.logIn()
        
        completion()
    }
    
    func signIn(completion: @escaping (Bool) -> Void) {
        useCase.signIn(request: .init(phoneNumber: phoneNumber)) { response in
            guard let response = response,
                  let _ = response.1.data,
                  let accessToken = response.0.value(forHTTPHeaderField: "authorization"),
                  let refreshToken = response.0.value(forHTTPHeaderField: "refresh")
            else {
                completion(false)
                return
            }
            
            self.setAuth(accessToken: accessToken, refreshToken: refreshToken) {
                completion(true)
            }
        }
    }
    
    func signUp(completion: @escaping (Bool) -> Void) {
        useCase.signIn(request: .init(phoneNumber: phoneNumber)) { response in
            guard let response = response,
                  let _ = response.1.data,
                  let accessToken = response.0.value(forHTTPHeaderField: "authorization"),
                  let refreshToken = response.0.value(forHTTPHeaderField: "refresh")
            else {
                completion(true)
                return
            }
            self.temporaryTokenData = (accessToken, refreshToken)
            completion(false)
        }
    }
}
