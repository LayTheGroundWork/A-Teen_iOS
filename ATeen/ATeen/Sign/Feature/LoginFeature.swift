//
//  LoginFeature.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import Foundation

@Reducer
struct LoginFeature {
    @ObservableState
    struct State: Equatable {
        var user: User = .init(name: "", phoneNumber: "", birth: "", schoolName: "", age: 0, gender: "")
        
        var codeNumber = ""
        var openCodeView = false
        var phoneNumber = ""
    }
    
    enum Action {
        case dataResponse(String)
        case loginWithKakao
        case openCodeView(Bool)
        case setCode(String)
        case setPhoneNumber(String)
    }
    
    @Dependency(\.kakaoLogin) var kakaoLogin
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .dataResponse(token):
                print(token)
                return .none
                
            case .loginWithKakao:
                return .run { send in
                    try await send(.dataResponse(self.kakaoLogin.login()))
                }
                
            case let .openCodeView(change):
                state.openCodeView = change
                return .none
                
            case let .setCode(text):
                state.codeNumber = text
                return .none
                
            case let .setPhoneNumber(text):
                state.phoneNumber = text
                state.user.phoneNumber = text
                return .none
            }
        }
    }
}
