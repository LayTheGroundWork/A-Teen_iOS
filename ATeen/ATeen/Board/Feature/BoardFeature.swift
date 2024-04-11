//
//  BoardFeature.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import Foundation

enum BoardType: String, CaseIterable {
    case freeBoard = "자유게시판"
    case secretBoard = "비밀게시판"
}

@Reducer
struct BoardFeature {
    @ObservableState
    struct State: Equatable {
        let boardTypes: [String] = [BoardType.freeBoard.rawValue, BoardType.secretBoard.rawValue]
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

extension BoardFeature {
    @Reducer
    struct Path {
        @ObservableState
        enum State: Equatable {
            case noticeBoardScene(NoticeBoardFeature.State)
            case postDetailScene(PostDetailFeature.State)
        }
        
        enum Action {
            case noticeBoardScene(NoticeBoardFeature.Action)
            case postDetailScene(PostDetailFeature.Action)

        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.noticeBoardScene, action: \.noticeBoardScene) {
                NoticeBoardFeature()
            }
            Scope(state: \.postDetailScene, action: \.postDetailScene) {
                PostDetailFeature()
            }
        }
    }
}

