//
//  ProfileFeature.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import Foundation

@Reducer
struct ProfileFeature {
    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()

    }
    
    enum Action {
        case openSetting
        case path(StackAction<Path.State, Path.Action>)

    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .openSetting:
                state.path.append(.settingScene(SettingFeature.State()))
                return .none
                
            case let .path(action):
                switch action {
                default:
                    return .none
                }
            }
        }
    }
}

extension ProfileFeature {
    @Reducer
    struct Path {
        @ObservableState
        enum State: Equatable {
            case settingScene(SettingFeature.State)
        }
        
        enum Action {
            case settingScene(SettingFeature.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.settingScene, action: \.settingScene) {
                SettingFeature()
            }
        }
    }
}
