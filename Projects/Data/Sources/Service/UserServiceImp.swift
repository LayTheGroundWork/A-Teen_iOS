//
//  UserServiceImp.swift
//  Data
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import Domain
import Foundation

public struct UserServiceImp: UserService {
    public let auth: Auth
    private let allUserFindRepository: AllUserFindRepository
    private let categoryUserFindRepository: CategoryUserFindRepository
    private let userDetailRepository: UserDetailRepository
    private let userLikeRepository: UserLikeRepository
    private let userLikeCancelRepository: UserLikeCancelRepository
    private let reissueRepository: ReissueRepository

    public init(
        auth: Auth,
        allUserFindRepository: AllUserFindRepository,
        categoryUserFindRepository: CategoryUserFindRepository,
        userDetailRepository: UserDetailRepository,
        userLikeRepository: UserLikeRepository,
        userLikeCancelRepository: UserLikeCancelRepository,
        reissueRepository: ReissueRepository
    ) {
        self.auth = auth
        self.allUserFindRepository = allUserFindRepository
        self.categoryUserFindRepository = categoryUserFindRepository
        self.userDetailRepository = userDetailRepository
        self.userLikeRepository = userLikeRepository
        self.userLikeCancelRepository = userLikeCancelRepository
        self.reissueRepository = reissueRepository
    }
    
    public func findAllUser(request: AllUserFindRequest) async -> UserData {
        let response = await allUserFindRepository.findAllUser(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(let error):
            switch error.localizedDescription {
            case AppLocalized.expiredToken:
                guard let newToken = await reissueToken() else {
                    return .init(users: [], totalPage: 0)
                }
                return await findAllUser(request: .init(
                    authorization: newToken,
                    page: request.page,
                    size: request.size))
                
            case AppLocalized.unauthorizedToken:
                auth.logOut()
                return await findAllUser(request: .init(
                    authorization: nil,
                    page: request.page,
                    size: request.size))
            default:
                return .init(users: [], totalPage: 0)
            }
        }
    }
    
    public func findCategoryUser(request: CategoryUserFindRequest) async -> UserData {
        let response = await categoryUserFindRepository.findCategoryUser(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(let error):
            switch error.localizedDescription {
            case AppLocalized.expiredToken:
                guard let newToken = await reissueToken() else {
                    return .init(users: [], totalPage: 0)
                }
                
                return await findCategoryUser(request: .init(
                    authorization: newToken,
                    category: request.category,
                    page: request.page,
                    size: request.size))
            default:
                return .init(users: [], totalPage: 0)
            }
        }
    }
    
    public func getUserDetailData(request: UserDetailRequest) async -> UserDetailData? {
        let response = await userDetailRepository.getUserDetailData(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(_):
            return nil
        }
    }
  
    public func updateUserLikeStatus(request: UserLikeRequest) async -> String? {
        let response = await userLikeRepository.updateUserLikeStatus(request: request)
      
        switch response {
        case .success(let response):
            return response.data
        case .failure(let error):
            switch error.localizedDescription {
            case AppLocalized.expiredToken:
                guard let newToken = await reissueToken() else {
                    return nil
                }
                
                return await updateUserLikeStatus(request: .init(
                    authorization: newToken,
                    id: request.id))
            default:
                return nil
            }
        }
    }
    
    public func cancelUserLikeStatus(request: UserLikeRequest) async -> String? {
        let response = await userLikeCancelRepository.cancelUserLikeStatus(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(let error):
            switch error.localizedDescription {
            case AppLocalized.expiredToken:
                guard let newToken = await reissueToken() else {
                    return nil
                }
                
                return await cancelUserLikeStatus(request: .init(
                    authorization: newToken,
                    id: request.id))
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
