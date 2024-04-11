//
//  ProfileView.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

struct ProfileView: View {
    @Bindable var store: StoreOf<ProfileFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack {
                Button {
                    store.send(.openSetting)
                } label: {
                    Text("Setting")
                }
                
                Text("Profile")
            }
        } destination: { store in
            switch store.state {
            case .settingScene(_):
                if let store = store.scope(state: \.settingScene, action: \.settingScene) {
                    SettingView(store: store)
                }
            
            }
        }
    }
}

