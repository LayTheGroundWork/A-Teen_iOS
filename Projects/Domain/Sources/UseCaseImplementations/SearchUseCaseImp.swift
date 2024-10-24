//
//  SearchUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 7/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct SearchUseCaseImp: SearchUseCase {
    let schoolDataRepository: SchoolDataRepository
    
    public init(
        schoolDataRepository: SchoolDataRepository
    ) {
        self.schoolDataRepository = schoolDataRepository
    }
    
    public func searchSchool(request: SchoolDataRequest, completion: @escaping (Result<[SchoolDataResponse], Error>) -> Void) {
        schoolDataRepository.searchSchool(request: request, completion: completion)
    }
}
