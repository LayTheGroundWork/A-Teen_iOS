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
        var user: User

        var codeNumber = ""
        var openCodeView = false
        var phoneNumber = ""
    }
    
    enum Action {
        case openCodeView(Bool)
        case setCode(String)
        case setPhoneNumber(String)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
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
