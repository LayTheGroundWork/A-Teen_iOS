//
//  NoteFeature.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import Foundation

@Reducer
struct NoteFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?

        let title: Int
    }
    
    enum Action {
        case destination(PresentationAction<Destination.Action>)
        case openWrite
        case tabBackButton
    }
    
    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .destination:
                return .none
                
            case .openWrite:
                state.destination = .openWrite(NoteWriteFeature.State())
                return .none
                
            case .tabBackButton:
                return .run { _ in
                    await self.dismiss()
                }
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension NoteFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case openWrite(NoteWriteFeature)
    }
}
