//
//  SearchUserRequest.swift
//  Domain
//
//  Created by 노주영 on 1/3/25.
//  Copyright © 2025 ATeen. All rights reserved.
//

import Foundation

public struct SearchUserRequest {
    public let searchWord: String
    
    public init(
        searchWord: String
    ) {
        self.searchWord = searchWord
    }
}
