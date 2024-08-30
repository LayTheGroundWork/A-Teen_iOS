//
//  DuplicationCheckResponse.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct DuplicationCheckResponse: Decodable {
    public let data: Bool

    public init(data: Bool) {
        self.data = data
    }
}
