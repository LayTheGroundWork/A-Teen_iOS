//
//  CategoryTodayTeenFindRepository.swift
//  Domain
//
//  Created by 노주영 on 1/3/25.
//  Copyright © 2025 ATeen. All rights reserved.
//

import Foundation

public protocol CategoryTodayTeenFindRepository {
    func findCategoryTodayTeen(request: CategoryTodayTeenFindRequest) async -> Result<TodayTeenFindResponse, Error>
}
