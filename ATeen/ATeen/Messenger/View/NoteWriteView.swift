//
//  NoteWriteView.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture

import SwiftUI

struct NoteWriteView: View {
    @Bindable var store: StoreOf<NoteWriteFeature>
    
    var body: some View {
        Text("Write Note")
    }
}
