//
//  WriteFeature.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import Foundation

@Reducer
struct PostWriteFeature {
    @ObservableState
    struct State: Equatable {
      
    }
    
    enum Action {
        case tabBackButton
    }
    
    @Dependency(\.dismiss) var dismiss

    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tabBackButton:
                return .run { _ in
                    await self.dismiss()
                }
            }
        }
    }
}
