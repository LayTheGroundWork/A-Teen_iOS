//
//  LoginCodeView.swift
//  ATeen
//
//  Created by 최동호 on 4/15/24.
//

import ComposableArchitecture

import SwiftUI

struct LoginCodeView: View {
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
                
                Text("\(store.user.phoneNumber)로 인증코드를 보냈어요")
                    .font(.system(.title2))
                    .fontWeight(.medium)
                    .padding(.horizontal)
       
                VStack(alignment: .leading, spacing: 20) {
                    
                    HStack(alignment: .top, spacing: 8, content: {
                        VStack(alignment: .leading, spacing: 8, content: {
                            TextField("코드 입력", text: $store.codeNumber.sending(\.setCode))
                                .multilineTextAlignment(.leading)
                                .autocorrectionDisabled()
                            
                            Divider()
                        })
                    })
                        .tint(.white)
                        .keyboardType(.numberPad)
                    
                }
                .padding(.horizontal)
                
                Spacer()
                
                Spacer()
                
                Button {

                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.width * 0.9, height: 45)
                            .foregroundStyle(Color(red: 250/255, green: 250/255, blue: 250/255))
                        
                        HStack {
                            Text("다음으로")
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
    }
}

