//
//  SchoolDataRepository.swift
//  Domain
//
//  Created by 최동호 on 7/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol SchoolDataRepository {
    func searchSchool(
        request: SchoolDataRequest,
        completion: @escaping (Result<SchoolDataResponse, Error>) -> Void
    )
}
