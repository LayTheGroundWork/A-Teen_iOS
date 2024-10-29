//
//  CategoryUserFindRepository.swift
//  Domain
//
//  Created by 노주영 on 10/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol CategoryUserFindRepository {
    func findCategoryUser(request: CategoryUserFindRequest) async -> Result<UserFindResponse, Error>
}
