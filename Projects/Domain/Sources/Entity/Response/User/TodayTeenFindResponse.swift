//
//  TodayTeenFindResponse.swift
//  Domain
//
//  Created by 노주영 on 1/3/25.
//  Copyright © 2025 ATeen. All rights reserved.
//

import Common
import Foundation

public struct TodayTeenFindResponse: Decodable {
    public let data: [User]
    
    public init(data: [User]) {
        self.data = data
    }
}
