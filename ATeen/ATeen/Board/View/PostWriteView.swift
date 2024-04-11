//
//  WriteView.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

struct PostWriteView: View {
    @Bindable var store: StoreOf<PostWriteFeature>
    
    var body: some View {
        Text("Post Write")
    }
}

