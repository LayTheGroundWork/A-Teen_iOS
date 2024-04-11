//
//  PostDetailFeature.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import Foundation

@Reducer
struct PostDetailFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?

    }
    
    enum Action {
        case destination(PresentationAction<Destination.Action>)
        case openWrite
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .destination:
                return .none
                
            case .openWrite:
                state.destination = .openWrite(NoteWriteFeature.State())
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)

    }
}

extension PostDetailFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case openWrite(NoteWriteFeature)
    }
}
