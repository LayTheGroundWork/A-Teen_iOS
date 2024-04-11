//
//  NoticeView.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

struct NoticeView: View {
    @Bindable var store: StoreOf<NoticeFeature>
    
    var body: some View {
        Text("Notice")
    }
}
