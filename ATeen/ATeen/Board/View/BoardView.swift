//
//  BoardView.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

struct BoardView: View {
    @Bindable var store: StoreOf<BoardFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack {
                ForEach(store.boardTypes, id:\.self) { boardType in
                    NavigationLink(state: BoardFeature.Path.State.noticeBoardScene(.init(boardTitle: boardType))) {
                        Text(boardType)
                    }
                }
                
                Text("Board")
            }
        } destination: { store in
            switch store.state {
            case .noticeBoardScene(_):
                if let store = store.scope(state: \.noticeBoardScene, action: \.noticeBoardScene) {
                    NoticeBoardView(store: store)
                }
            case .postDetailScene(_):
                if let store = store.scope(state: \.postDetailScene, action: \.postDetailScene) {
                    PostDetailView(store: store)
                }
            }
        }
    }
}


