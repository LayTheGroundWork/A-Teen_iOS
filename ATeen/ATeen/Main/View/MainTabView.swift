//
//  MainTabView.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

struct MainTabView: View {
    @Bindable var store: StoreOf<MainTabFeature>
     
    var body: some View {
        if !store.isFetchedData {
            SplashView()
        } else {
            TabView(selection: $store.tabState.sending(\.changeTab)) {
                HomeView(
                    store: Store(
                        initialState: HomeFeature.State()) {
                            HomeFeature()
                    }
                )
                .tabItem {
                    Label("", systemImage: "house")
                }
                .tag(TabState.Home)
                
                BoardView(
                    store: Store(
                        initialState: BoardFeature.State()) {
                            BoardFeature()
                    }
                )
                .tabItem {
                    Label("", systemImage: "square.and.pencil")
                }
                .tag(TabState.Board)
                
                MessengerView(
                    store: Store(
                        initialState: MessengerFeature.State()) {
                            MessengerFeature()
                    }
                )
                .tabItem {
                    Label("", systemImage: "message")
                }
                .tag(TabState.Messenger)
                
                ProfileView(
                    store: Store(
                        initialState: ProfileFeature.State()) {
                            ProfileFeature()
                    }
                )
                .tabItem {
                    Label("", systemImage: "person")
                }
                .tag(TabState.Profile)
            }
            .onChange(of: store.tabState) { oldValue, newValue in
                if newValue == TabState.Profile {
                    store.send(.openLoginView)
                }
            }
            .sheet(
                item: $store.scope(state: \.destination?.openLoginView, action: \.destination.openLoginView)
            ) { LoginFeature in
                LoginView(store: LoginFeature)
            }
        }
    }
}

