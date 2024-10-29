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
    
    public func getMyPageData(request: MyPageRequest) async -> MyPageData? {
        let response = await myPageRepository.getMyPageData(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(_):
            return nil
        }
    }
    
    public func editMyPage(request: MyPageEditRequest) async -> String? {
        let response = await myPageEditRepository.editMyPage(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(_):
            return nil
        }
    }
}
