//
//  UserServiceImp.swift
//  Data
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct UserServiceImp: UserService {
    private let allUserFindRepository: AllUserFindRepository
    private let categoryUserFindRepository: CategoryUserFindRepository
    
    public init(
        allUserFindRepository: AllUserFindRepository,
        categoryUserFindRepository: CategoryUserFindRepository
    ) {
        self.allUserFindRepository = allUserFindRepository
        self.categoryUserFindRepository = categoryUserFindRepository
    }
    
    public func findAllUser(request: AllUserFindRequest, completion: @escaping ([UserData]) -> Void) {
        allUserFindRepository.findAllUser(request: request) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    public func findCategoryUser(request: CategoryUserFindRequest, completion: @escaping ([UserData]) -> Void) {
        categoryUserFindRepository.findCategoryUser(request: request) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
}
