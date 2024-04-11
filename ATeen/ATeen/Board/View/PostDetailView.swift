//
//  PostDetailView.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//


import ComposableArchitecture

import SwiftUI

struct PostDetailView: View {
    @Bindable var store: StoreOf<PostDetailFeature>
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    store.send(.openWrite)
                } label: {
                    Text("Message")
                }
            }
            .padding()
            
            Form {
                Text("Content")
            }
            
            Form {
                HStack {
                    Text("Comment")
                    
                    Spacer()
                    
                    Button {
                        store.send(.openWrite)
                    } label: {
                        Text("Message")
                            .foregroundStyle(.blue)
                    }
                }
            }

        }
        .sheet(
            item: $store.scope(state: \.destination?.openWrite, action: \.destination.openWrite)
        ) { NoteWriteFeature in
            NoteWriteView(store: NoteWriteFeature)
        }
    }
}
