//
//  MyPageServiceImp.swift
//  Data
//
//  Created by 노주영 on 10/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import Domain
import Foundation

public struct MyPageServiceImp: MyPageService {
    private let auth: Auth
    private let myPageRepository: MyPageRepository
    private let myPageEditRepository: MyPageEditRepository
    private let reissueRepository: ReissueRepository

    public init(
        auth: Auth,
        myPageRepository: MyPageRepository,
        myPageEditRepository: MyPageEditRepository,
        reissueRepository: ReissueRepository
    ) {
        self.auth = auth
        self.myPageRepository = myPageRepository
        self.myPageEditRepository = myPageEditRepository
        self.reissueRepository = reissueRepository
    }
    
    public func getMyPageData(request: MyPageRequest) async -> MyPageData? {
        let response = await myPageRepository.getMyPageData(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(let error):
            switch error.localizedDescription {
            case AppLocalized.expiredToken:
                guard let newToken = await reissueToken() else {
                    return nil
                }
                return await getMyPageData(request: .init(authorization: newToken))
            default:
                return nil
            }
        }
    }
    
    public func editMyPage(request: MyPageEditRequest) async -> String? {
        let response = await myPageEditRepository.editMyPage(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(let error):
            switch error.localizedDescription {
            case AppLocalized.expiredToken:
                guard let newToken = await reissueToken() else {
                    return nil
                }
                
                return await editMyPage(request: .init(
                    authorization: newToken,
                    nickName: request.nickName,
                    schoolData: request.schoolData,
                    snsPlatform: request.snsPlatform,
                    mbti: request.mbti,
                    introduction: request.introduction,
                    questions: request.questions))
            default:
                return nil
            }
        }
    }
    
    public func getAuthToken() -> String? {
        return auth.getAccessToken()
    }
    
    private func reissueToken() async -> String? {
        guard let token = auth.getAccessToken(),
              let refresh = auth.getRefreshToken() else { return nil }
        let response = await reissueRepository.reissueToken(request: .init(authorization: token, refresh: refresh))
        
        switch response {
        case .success(let response):
            return setTokens(response: response.0)
        case .failure(_):
            return nil
        }
    }
    
    private func setTokens(response: HTTPURLResponse) -> String? {
        guard let accessToken = response.value(forHTTPHeaderField: "authorization"),
              let refreshToken = response.value(forHTTPHeaderField: "refresh") else { return nil }

        auth.setAccessToken(accessToken)
        auth.setRefreshToken(refreshToken)
        return accessToken
    }
}
