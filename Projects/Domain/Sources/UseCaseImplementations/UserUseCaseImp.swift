//
//  UserUseCaseImp.swift
//  Domain
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Combine
import Common

public struct UserUseCaseImp: UserUseCase {
    public let userService: UserService
    
    public init(userService: UserService) {
        self.userService = userService
    }
    
    public func findCategoryTodatTeen(request: CategoryTodayTeenFindRequest) -> AnyPublisher<[User], Never> {
        Future { promise in
            Task {
                let data = await userService.findCategoryTodayTeen(request: request)
                promise(.success(data))
            }
        }
        .eraseToAnyPublisher()
    }

    public func findCategoryUser(request: CategoryUserFindRequest) -> AnyPublisher<UserData, Never> {
        Future { promise in
            Task {
                let data = await userService.findCategoryUser(request: request)
                promise(.success(data))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func getUserDetailData(request: UserDetailRequest) -> AnyPublisher<UserDetailData?, Never> {
        Future { promise in
            Task {
                let data = await userService.getUserDetailData(request: request)
                promise(.success(data))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func updateUserLikeStatus(request: UserLikeRequest) -> AnyPublisher<String?, Never> {
        Future { promise in
            Task {
                let data = await userService.updateUserLikeStatus(request: request)
                promise(.success(data))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func cancelUserLikeStatus(request: UserLikeRequest) -> AnyPublisher<String?, Never> {
        Future { promise in
            Task {
                let data = await userService.cancelUserLikeStatus(request: request)
                promise(.success(data))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func getAuthToken() -> String? {
        userService.getAuthToken()
    }
}
