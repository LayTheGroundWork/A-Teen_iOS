//
//  SignUpRequest.swift
//  Domain
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct SignUpRequest {
    public let phoneNumber: String
    public let userId: String
    public let userName: String
    public let birthDate: String
    public let schoolData: SchoolData
    public let category: String
    public let tournamentJoin: Bool

    public init(
        phoneNumber: String,
        userId: String,
        userName: String,
        birthDate: String,
        schoolData: SchoolData,
        category: String,
        tournamentJoin: Bool
    ) {
        self.phoneNumber = phoneNumber
        self.userId = userId
        self.userName = userName
        self.birthDate = birthDate
        self.schoolData = schoolData
        self.category = category
        self.tournamentJoin = tournamentJoin
    }
}


public struct SchoolData {
    public let schoolName: String
    public let schoolLocation: String
    
    public init(
        schoolName: String,
        schoolLocation: String
    ) {
        self.schoolName = schoolName
        self.schoolLocation = schoolLocation
    }
}

infix operator == : ComparisonPrecedence

extension SchoolData {
    public static func == (lhs: SchoolData, rhs: SchoolData) -> Bool {
        lhs.schoolName == rhs.schoolName && lhs.schoolLocation == rhs.schoolLocation
    }
}
// Date 변환하는 로직 core에 추가 후 여기서 처리 필요
