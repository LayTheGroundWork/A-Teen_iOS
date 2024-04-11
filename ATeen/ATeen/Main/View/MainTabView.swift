//
//  MainTabView.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

struct MainTabView: View {
    let store: StoreOf<MainTabFeature>
    
    var body: some View {
        if !store.isFetchedData {
            SplashView()
        } else {
            TabView {
                HomeView(
                    store: Store(
                        initialState: HomeFeature.State()) {
                            HomeFeature()
                    }
                )
                .tabItem {
                    Label("", systemImage: "house")
                }
                .tag("Home")
                
                BoardView(
                    store: Store(
                        initialState: BoardFeature.State()) {
                            BoardFeature()
                    }
                )
                .tabItem {
                    Label("", systemImage: "square.and.pencil")
                }
                .tag("Board")
                
                MessengerView(
                    store: Store(
                        initialState: MessengerFeature.State()) {
                            MessengerFeature()
                    }
                )
                .tabItem {
                    Label("", systemImage: "message")
                }
                .tag("Messenger")
                
                ProfileView(
                    store: Store(
                        initialState: ProfileFeature.State()) {
                            ProfileFeature()
                    }
                )
                .tabItem {
                    Label("", systemImage: "person")
                }
                .tag("Profile")
            }
        }
    }
}

