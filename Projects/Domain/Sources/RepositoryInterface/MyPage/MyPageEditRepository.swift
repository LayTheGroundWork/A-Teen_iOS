//
//  MyPageEditRepository.swift
//  Domain
//
//  Created by 노주영 on 10/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol MyPageEditRepository {
    func editMyPage(request: MyPageEditRequest) async -> Result<DefaultResponse, Error>
}
