//
//  OtherUserProfile.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

struct OtherUserProfile: View {
    @Bindable var store: StoreOf<OtherUserProfileFeature>
    
    var body: some View {
        Text("Other User Profile")
    }
}

