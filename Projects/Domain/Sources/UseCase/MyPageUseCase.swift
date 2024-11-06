//
//  MyPageUseCase.swift
//  Domain
//
//  Created by 노주영 on 10/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Combine
import Common

public protocol MyPageUseCase {
    func getMyPageData(request: MyPageRequest) -> AnyPublisher<MyPageData?, Never>
    func editMyPage(request: MyPageEditRequest) -> AnyPublisher<String?, Never>
    func searchSchool(request: SchoolDataRequest) -> AnyPublisher<[SchoolData], Never>
}

