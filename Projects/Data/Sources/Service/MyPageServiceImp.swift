//
//  MyPageServiceImp.swift
//  Data
//
//  Created by 노주영 on 10/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct MyPageServiceImp: MyPageService {
    private let myPageRepository: MyPageRepository
    private let myPageEditRepository: MyPageEditRepository

    public init(
        myPageRepository: MyPageRepository,
        myPageEditRepository: MyPageEditRepository
    ) {
        self.myPageRepository = myPageRepository
        self.myPageEditRepository = myPageEditRepository
    }
    
    public func getMyPageData(
        request: MyPageRequest,
        completion: @escaping (MyPageData?) -> Void
    ) {
        myPageRepository.getMyPageData(request: request) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    public func editMyPage(
        request: MyPageEditRequest,
        completion: @escaping (String?) -> Void
    ) {
        myPageEditRepository.editMyPage(request: request) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
