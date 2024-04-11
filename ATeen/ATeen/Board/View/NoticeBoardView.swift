//
//  NoticeBoardView.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

struct NoticeBoardView: View {
    @Bindable var store: StoreOf<NoticeBoardFeature>
    
    var body: some View {
        VStack {
            HStack {
                Text(store.boardTitle)
                
                Spacer()
                
                Button {
                    store.send(.openWrite)
                } label: {
                    Text("Post Write")
                }
              
            }
            .padding()
            
            NavigationLink(state: BoardFeature.Path.State.postDetailScene(.init())) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray)
                    .frame(height: 30)
                    .padding()
            }
            
            Spacer()
        }
        .sheet(
            item: $store.scope(state: \.destination?.openWrite, action: \.destination.openWrite)
        ) { PostWriteFeature in
            PostWriteView(store: PostWriteFeature)
        }
    }
}

