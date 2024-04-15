//
//  LoginView.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

struct LoginView: View {
    @Bindable var store: StoreOf<LoginFeature>
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    
                } label: {
                    Text("카카오")
                }
                
                Button {
                    
                } label: {
                    Text("메타")
                }
                
                Button {
                    
                } label: {
                    Text("애플")
                }
                
                NavigationLink {
                    LoginPhoneNumberView(store: store)
                } label: {
                    Text("전화번호 로그인")
                }
            }
        }
    }
}
