//
//  PhoneNumberViewModel.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import Core
import Combine
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

    var state = PassthroughSubject<SignStateController, Never>()
    private var cancellables = Set<AnyCancellable>()
}

// MARK: - 인증
extension PhoneNumberViewModel {
    func sampleRequestCode() {
        self.state.send(.codeRequested)
    }
    
    func requestCode() {
        useCase.requestCode(request: VerificationCodeRequest(phoneNumber: self.phoneNumber))
            .sink { [weak self] _ in
                self?.state.send(.codeRequested)
            }
            .store(in: &cancellables)
    }
    
    func verifyCode() {
        useCase.verifyCode(request: .init(phoneNumber: phoneNumber, verificationCode: verificationCode))
            .sink { [weak self] data in
                guard let self else { return }
                if let _ = data {
                    switch self.signType {
                    case .signIn:
                        self.signIn()
                    case .signUp:
                        self.signUp()
                    }
                } else {
                    //self.state.send(.verificationFailed)
                    switch self.signType {
                    case .signIn:
                        self.signIn()
                    case .signUp:
                        self.signUp()
                    }
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - 회원가입 및 로그인
extension PhoneNumberViewModel {
    func changeSignType(signType: SignType) {
        self.signType = signType
    }
    
    func setAuth(accessToken: String, refreshToken: String) {
        self.auth.setAccessToken(accessToken)
        self.auth.setRefreshToken(refreshToken)
        self.auth.logIn()
    }
    
    func signIn() {
        useCase.signIn(request: .init(phoneNumber: phoneNumber))
            .sink { [weak self] response in
                guard let self = self,
                      let response = response,
                      let _ = response.1.data,
                      let accessToken = response.0.value(forHTTPHeaderField: "authorization"),
                      let refreshToken = response.0.value(forHTTPHeaderField: "refresh")
                else {
                    self?.state.send(.signInFailed)
                    return
                }
                
                self.setAuth(accessToken: accessToken, refreshToken: refreshToken)
                self.state.send(.signInSuccess)
            }
            .store(in: &cancellables)
    }
    
    func signUp() {
        useCase.signIn(request: .init(phoneNumber: phoneNumber))
            .sink { [weak self] response in
                guard let self = self,
                      let response = response,
                      let _ = response.1.data,
                      let accessToken = response.0.value(forHTTPHeaderField: "authorization"),
                      let refreshToken = response.0.value(forHTTPHeaderField: "refresh")
                else {
                    self?.state.send(.goToSignUp)
                    return
                }
                self.temporaryTokenData = (accessToken, refreshToken)
                self.state.send(.existingUser)
            }
            .store(in: &cancellables)
    }
}
