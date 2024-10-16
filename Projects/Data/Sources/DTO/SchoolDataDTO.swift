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
    public let status: Int
    public let data: [SchoolData]
    public let message: String
}

extension SchoolDataDTO {
    func toDomain() -> [SchoolDataResponse] {
        var tmp: [SchoolDataResponse] = []
        data.forEach { schoolData in
            let name = schoolData.schoolName
            let address = schoolData.schoolLocation
            
            tmp.append(.init(name: name, address: address))
        }
        return tmp
    }
}
