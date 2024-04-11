//
//  HomeView.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

struct HomeView: View {
    @Bindable var store: StoreOf<HomeFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack {
                Button {
                    store.send(.openNotice)
                } label: {
                    Text("Notice")
                }
                
                Button {
                    store.send(.openOtherUserProfile)
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.blue)
                        .frame(width: 30, height: 30)
                }
                Text("Home")
            }
        } destination: { store in
            switch store.state {
            case .noticeScene(_):
                if let store = store.scope(state: \.noticeScene, action: \.noticeScene) {
                    NoticeView(store: store)
                }
            
            case .otherUserProfileScene(_):
                if let store = store.scope(state: \.otherUserProfileScene, action: \.otherUserProfileScene) {
                    OtherUserProfile(store: store)
                }
            }
        }
    }
}

