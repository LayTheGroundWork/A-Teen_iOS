//
//  SchoolDataDTO.swift
//  Data
//
//  Created by 최동호 on 7/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct SchoolDataDTO: Decodable {
    public let status: String
    public let data: [SchoolData]
    public let message: String
}

public struct SchoolData: Decodable {
    public let schoolName: String
    public let schoolRegion: String
    
    enum CodingKeys: String, CodingKey {
        case schoolName = "SCHUL_NM"
        case schoolRegion = "ORG_RDNMA"
    }
}

extension SchoolDataDTO {
    func toDomain() -> [SchoolDataResponse] {
        var tmp: [SchoolDataResponse] = []
        data.forEach { schoolData in
            let name = schoolData.schoolName
            let address = schoolData.schoolRegion
            
            tmp.append(.init(name: name, address: address))
        }
        return tmp
    }
}
