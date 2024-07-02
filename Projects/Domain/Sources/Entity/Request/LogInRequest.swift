//
//  LogInRequest.swift
//  Domain
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct LogInRequest {
    public let phoneNumber: String
    public let verificationCode: String
    
    public init(
        phoneNumber: String,
        verificationCode: String
    ) {
        self.phoneNumber = phoneNumber
        self.verificationCode = verificationCode
    }
}
