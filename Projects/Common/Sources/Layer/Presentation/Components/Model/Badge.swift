//
//  Badge.swift
//  Common
//
//  Created by 노주영 on 9/13/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

public struct Badge {
    public let type: BadgeType
    public let explain: String
    
    public init(
        type: BadgeType,
        explain: String
    ) {
        self.type = type
        self.explain = explain
    }
}
