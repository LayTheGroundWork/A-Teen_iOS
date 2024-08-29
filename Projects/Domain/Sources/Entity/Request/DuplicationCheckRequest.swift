//
//  DuplicationCheckRequest.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct DuplicationCheckRequest {
    public let uniqueId: String
    
    public init(uniqueId: String) {
        self.uniqueId = uniqueId
    }
}
