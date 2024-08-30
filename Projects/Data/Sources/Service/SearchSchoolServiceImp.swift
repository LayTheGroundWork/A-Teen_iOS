//
//  SearchSchoolServiceImp.swift
//  Domain
//
//  Created by 최동호 on 7/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct SearchSchoolServiceImp: SearchSchoolService {
    let schoolDataRepository: SchoolDataRepository
    
    public init(
        schoolDataRepository: SchoolDataRepository
    ) {
        self.schoolDataRepository = schoolDataRepository
    }
    
    public func searchSchool(request: SchoolDataRequest, completion: @escaping ([SchoolData]) -> Void) {
        schoolDataRepository.searchSchool(request: request) { result in
            switch result {
            case .success(let schoolDataResponses):
                let filteredSchools: [SchoolData] = schoolDataResponses.map {
                    .init(
                        schoolName: $0.name,
                        schoolLocation: $0.address
                    )
                }
                
                if !filteredSchools.isEmpty {
                    completion(filteredSchools)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
