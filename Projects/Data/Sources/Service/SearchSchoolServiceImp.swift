//
//  SearchSchoolServiceImp.swift
//  Data
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Domain
import Foundation

public struct SearchSchoolServiceImp: SearchSchoolService {
    let schoolDataRepository: SchoolDataRepository
    
    public init(
        schoolDataRepository: SchoolDataRepository
    ) {
        self.schoolDataRepository = schoolDataRepository
    }
    
    public func searchSchool(request: SchoolDataRequest) async -> [SchoolData] {
        let response = await schoolDataRepository.searchSchool(request: request)
        
        switch response {
        case .success(let response):
            print(response.data)
            return response.data
        case .failure(_):
            return []
        }
    }
}
