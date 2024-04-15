//
//  KaKaoAPI.swift
//  ATeen
//
//  Created by 노주영 on 4/15/24.
//

import ComposableArchitecture
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

import Foundation

struct KaKaoAPI {
    var login: () async throws -> String
}

extension KaKaoAPI: DependencyKey {
    static let liveValue = Self(
        login: {
            return await withCheckedContinuation { continuation in
                Task {
                    await MainActor.run {
                        if (UserApi.isKakaoTalkLoginAvailable()) {
                            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                                guard let oauthToken = oauthToken, error == nil else { return }
                                continuation.resume(returning: oauthToken.accessToken)
                            }
                        } else {
                            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                                guard let oauthToken = oauthToken, error == nil else { return }
                                continuation.resume(returning: oauthToken.accessToken)
                            }
                        }
                    }
                }
            }
        }
    )
}

extension DependencyValues {
    var kakaoLogin: KaKaoAPI {
        get { self[KaKaoAPI.self] }
        set { self[KaKaoAPI.self] = newValue }
    }
}

