//
//  SchoolData.swift
//  Common
//
//  Created by 최동호 on 11/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct SchoolData: Codable {
    public let schoolName: String
    public let schoolLocation: String
    
    public init(
        schoolName: String,
        schoolLocation: String
    ) {
        self.schoolName = schoolName
        self.schoolLocation = schoolLocation
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DefaultKeys.self)
        try container.encode(schoolName, forKey: .schoolName)
        try container.encode(schoolLocation, forKey: .schoolLocation)
    }
    
    private enum CodingKeys: String, CodingKey {
        case schoolName = "SCHUL_NM"
        case schoolLocation = "ORG_RDNMA"
    }
    
    // 기본 키를 사용하기 위한 CodingKey
    private enum DefaultKeys: String, CodingKey {
        case schoolName
        case schoolLocation
    }
}

infix operator == : ComparisonPrecedence

extension SchoolData {
    public static func == (lhs: SchoolData, rhs: SchoolData) -> Bool {
        lhs.schoolName == rhs.schoolName && lhs.schoolLocation == rhs.schoolLocation
    }
}
// Date 변환하는 로직 core에 추가 후 여기서 처리 필요
