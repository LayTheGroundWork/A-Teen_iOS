//
//  ReissueRequest.swift
//  Domain
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct ReissueRequest {
    public let authorization: String
    public let refresh: String

    public init(
        authorization: String,
        refresh: String
    ) {
        self.authorization = authorization
        self.refresh = refresh
    }
}
