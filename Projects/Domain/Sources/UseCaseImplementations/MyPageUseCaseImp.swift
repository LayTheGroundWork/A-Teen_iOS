//
//  MyPageUseCaseImp.swift
//  Domain
//
//  Created by 노주영 on 10/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct MyPageUseCaseImp: MyPageUseCase {
    private let myPageService: MyPageService
    
    public init(
        myPageService: MyPageService
    ) {
        self.myPageService = myPageService
    }
    
    public func getMyPageData(
        request: MyPageRequest,
        completion: @escaping (MyPageData?) -> Void
    ) {
        myPageService.getMyPageData(request: request, completion: completion)
    }
    
    public func editMyPage(
        request: MyPageEditRequest,
        completion: @escaping (String?) -> Void
    ) {
        myPageService.editMyPage(request: request, completion: completion)
    }
}

