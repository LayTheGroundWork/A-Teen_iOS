//
//  HomeFeature.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import Foundation

@Reducer
struct HomeFeature {
    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()

    }
    
    enum Action {
        case openNotice
        case openOtherUserProfile
        case path(StackAction<Path.State, Path.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .openNotice:
                state.path.append(.noticeScene(NoticeFeature.State()))
                return .none
            case .openOtherUserProfile:
                state.path.append(.otherUserProfileScene(OtherUserProfileFeature.State()))
                return .none

            case let .path(action):
                switch action {
                default:
                    return .none
                }
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
}

extension HomeFeature {
    @Reducer
    struct Path {
        @ObservableState
        enum State: Equatable {
            case noticeScene(NoticeFeature.State)
            case otherUserProfileScene(OtherUserProfileFeature.State)
        }
        
        enum Action {
            case noticeScene(NoticeFeature.Action)
            case otherUserProfileScene(OtherUserProfileFeature.Action)

        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.noticeScene, action: \.noticeScene) {
                NoticeFeature()
            }
            
            Scope(state: \.otherUserProfileScene, action: \.otherUserProfileScene) {
                OtherUserProfileFeature()
            }
        }
    }
}

