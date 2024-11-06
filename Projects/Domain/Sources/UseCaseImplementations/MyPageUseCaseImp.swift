//
//  MyPageUseCaseImp.swift
//  Domain
//
//  Created by 노주영 on 10/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Combine
import Common

public struct MyPageUseCaseImp: MyPageUseCase {
    private let myPageService: MyPageService
    private let searchService: SearchSchoolService
    
    public init(
        myPageService: MyPageService,
        searchService: SearchSchoolService
    ) {
        self.myPageService = myPageService
        self.searchService = searchService
    }
    
    public func getMyPageData(request: MyPageRequest) -> AnyPublisher<MyPageData?, Never> {
        Future { promise in
            Task {
                let data = await myPageService.getMyPageData(request: request)
                promise(.success(data))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func editMyPage(request: MyPageEditRequest) -> AnyPublisher<String?, Never> {
        Future { promise in
            Task {
                let response = await myPageService.editMyPage(request: request)
                promise(.success(response))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func searchSchool(request: SchoolDataRequest) -> AnyPublisher<[SchoolData], Never> {
        Future { promise in
            Task {
                let schools = await searchService.searchSchool(request: request)
                promise(.success(schools))
            }
        }
        .eraseToAnyPublisher()
    }
}
