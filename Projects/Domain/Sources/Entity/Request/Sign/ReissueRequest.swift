//
//  ReissueRequest.swift
//  Domain
//
//  Created by 최동호 on 9/23/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct ReissueRequest {
    public let refresh: String
    public let authorization: String

    public init(
        refresh: String,
        authorization: String
    ) {
        self.refresh = refresh
        self.authorization = authorization
    }
}
