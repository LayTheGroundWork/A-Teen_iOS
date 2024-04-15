//
//  ATeenApp.swift
//  ATeen
//
//  Created by 최동호 on 4/11/24.
//

import ComposableArchitecture
import KakaoSDKAuth
import KakaoSDKCommon

import SwiftUI

@main
struct ATeenApp: App {
    static let store = Store(initialState: MainTabFeature.State()) {
        MainTabFeature()
            ._printChanges()
    }
    
    init() {
        if let kakaoURL = Bundle.main.kakaoURL {
            KakaoSDK.initSDK(appKey: kakaoURL)
        } else {
            print("kakaoAppKey를 찾을 수 없습니다.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView(
                store: ATeenApp.store
            )
            .onOpenURL { url in // 뷰가 속한 Window에 대한 URL을 받았을 때 호출할 Handler를 등록하는 함수
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
}
