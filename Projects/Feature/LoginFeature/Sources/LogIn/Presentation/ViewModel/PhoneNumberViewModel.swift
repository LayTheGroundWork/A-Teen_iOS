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
    @Injected(SignUseCase.self)
    public var useCase: SignUseCase
    
    public var signType: SignType = .signUp
    public var phoneNumber: String = .empty
    public var verificationCode: String = .empty

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

    func signIn() {
        useCase.signIn(request: .init(phoneNumber: phoneNumber))
            .sink { [weak self] data in
                guard let self = self,
                      let _ = data
                else {
                    self?.state.send(.signInFailed)
                    return
                }
                self.state.send(.signInSuccess)
            }
            .store(in: &cancellables)
    }
    
    func signUp() {
        useCase.signIn(request: .init(phoneNumber: phoneNumber))
            .sink { [weak self] data in
                guard let self = self,
                      let _ = data
                else {
                    self?.state.send(.goToSignUp)
                    return
                }
                self.state.send(.existingUser)
            }
            .store(in: &cancellables)
    }
}
