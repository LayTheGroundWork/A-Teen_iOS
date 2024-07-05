//
//  SchoolDataDTO.swift
//  Data
//
//  Created by 최동호 on 7/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

struct SchoolDataDTO: Decodable {
    public let status: String
    public let data: SchoolData
    public let message: String
}

struct SchoolData: Decodable {
    let schoolName: String
    let schoolRegion: String
    
    enum CodingKeys: String, CodingKey {
        case schoolName = "SCHUL_NM"
        case schoolRegion = "ORG_RDNMA"
    }
}

extension SchoolDataDTO {
    func toDomain() -> SchoolDataResponse {
        .init(
            name: data.schoolName,
            address: data.schoolRegion
        )
    }
}
