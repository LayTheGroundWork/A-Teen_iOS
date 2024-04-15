//
//  LoginPhoneNumberView.swift
//  ATeen
//
//  Created by 최동호 on 4/15/24.
//

import ComposableArchitecture

import SwiftUI

struct LoginPhoneNumberView: View {
    @Bindable var store: StoreOf<LoginFeature>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 2) {
                        Image(systemName: "chevron.left")
                            .font(.system(.subheadline))
                            .fontWeight(.medium)
                        
                        Text("뒤로")
                            .font(.system(.body))
                            .fontWeight(.medium)
                    }
                    .foregroundStyle(.black)
                }
                .padding()
                
                Spacer()
                
                Text("휴대폰 번호")
                    .font(.system(.title2))
                    .fontWeight(.medium)
                    .padding(.horizontal)
       
                VStack(alignment: .leading, spacing: 20) {
                    
                    HStack(alignment: .top, spacing: 8, content: {
                        VStack(alignment: .leading, spacing: 8, content: {
                            TextField("전화번호 입력", text: $store.phoneNumber.sending(\.setPhoneNumber))
                                .multilineTextAlignment(.leading)
                                .autocorrectionDisabled()
                            
                            Divider()
                        })
                    })
                        .tint(.white)
                        .keyboardType(.numberPad)
                    
                    Text("Thank you for Signing up the A-Teen")
                        .font(.system(.subheadline))
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Spacer()
                
                Button {
                    store.send(.openCodeView(true))
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 45)
                            .foregroundStyle(Color(red: 250/255, green: 250/255, blue: 250/255))
                        
                        HStack {
                            Text("인증 번호 전송")
                                .foregroundStyle(.black)
                                .font(.system(.subheadline))
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                                .foregroundStyle(.black)
                                .font(.system(.body))
                                .fontWeight(.medium)
                        }
                        .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                        .frame(height: 30)
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $store.openCodeView.sending(\.openCodeView)) {
            LoginCodeView(store: store)
        }
    }
}
