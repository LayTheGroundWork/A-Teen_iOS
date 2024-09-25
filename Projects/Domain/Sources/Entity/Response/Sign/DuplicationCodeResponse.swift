//
//  DuplicationCodeResponse.swift
//  Domain
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct DuplicationCheckResponse: Decodable {
    public let data: Bool

    public init(data: Bool) {
        self.data = data
    }
}
