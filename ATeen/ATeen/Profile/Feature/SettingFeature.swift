//
//  SettingFeature.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import Foundation

@Reducer
struct SettingFeature {
    @ObservableState
    struct State: Equatable {
      
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
