//
//  SchoolDataResponse.swift
//  Domain
//
//  Created by 최동호 on 7/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct SchoolDataResponse: Decodable {
    public let name: String
    public let address: String
    
    public init(
        name: String,
        address: String
    ) {
        self.name = name
        self.address = address
    }
}

