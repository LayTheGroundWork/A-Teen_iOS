//
//  MessengerView.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

struct MessengerView: View {
    @Bindable var store: StoreOf<MessengerFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack {
                ForEach(0..<10) { number in
                    NavigationLink(state: MessengerFeature.Path.State.noteScene(.init(title: number))) {
                        Text("\(number)")
                    }
                }
                
                Text("Board")
            }
        } destination: { store in
            switch store.state {
            case .noteScene(_):
                if let store = store.scope(state: \.noteScene, action: \.noteScene) {
                    NoteView(store: store)
                }
            }
        }
    }
}
