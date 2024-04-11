//
//  ATeenApp.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

@main
struct ATeenApp: App {
    static let store = Store(initialState: MainTabFeature.State()) {
        MainTabFeature()
            ._printChanges()
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainTabView(
                store: ATeenApp.store
            )
        }
    }
}
