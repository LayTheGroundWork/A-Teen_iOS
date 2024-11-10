//
//  ThisWeekParticipantsRequest.swift
//  Domain
//
//  Created by 노주영 on 10/31/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct ThisWeekParticipantsRequest {
    public let authorization: String
    public let category: String

    public init(
        authorization: String,
        category: String
    ) {
        self.authorization = authorization
        self.category = category
    }
}
