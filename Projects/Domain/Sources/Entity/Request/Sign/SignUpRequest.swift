//
//  SignUpRequest.swift
//  Domain
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Foundation

public struct SignUpRequest {
    public let profileImageKeys: [String] = []
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
