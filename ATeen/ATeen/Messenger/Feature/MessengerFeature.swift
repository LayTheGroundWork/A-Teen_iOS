//
//  MessengerFeature.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import Foundation

@Reducer
struct MessengerFeature {
    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()

    }
    
    enum Action {
        case path(StackAction<Path.State, Path.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
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

extension MessengerFeature {
    @Reducer
    struct Path {
        @ObservableState
        enum State: Equatable {
            case noteScene(NoteFeature.State)
        }
        
        enum Action {
            case noteScene(NoteFeature.Action)

        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.noteScene, action: \.noteScene) {
                NoteFeature()
            }
          
        }
    }
}
