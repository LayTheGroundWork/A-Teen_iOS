//
//  NoteView.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

struct NoteView: View {
    @Bindable var store: StoreOf<NoteFeature>

    var body: some View {
        VStack {
            HStack {
                Text("Note: \(store.title)")
                
                Spacer()
                
                Button {
                    store.send(.openWrite)
                } label: {
                    Text("Message")
                }
            }
            Spacer()
        }
        .padding()
        .sheet(
            item: $store.scope(state: \.destination?.openWrite, action: \.destination.openWrite)
        ) { NoteWriteFeature in
            NoteWriteView(store: NoteWriteFeature)
        }
    }
}


