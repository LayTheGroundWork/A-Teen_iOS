//
//  NoticeBoardFeature.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import Foundation

@Reducer
struct NoticeBoardFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        
        var boardTitle: String = ""
    }
    
    enum Action {
        case destination(PresentationAction<Destination.Action>)
        case openDetail
        case openWrite

    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .destination:
                return .none
            case .openDetail:
                return .none

            case .openWrite:
                state.destination = .openWrite(PostWriteFeature.State())
                return .none
      
            }
        }
        .ifLet(\.$destination, action: \.destination)

    }
}

extension NoticeBoardFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case openWrite(PostWriteFeature)
    }
}
