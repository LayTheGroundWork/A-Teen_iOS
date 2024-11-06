//
//  SchoolDataResponse.swift
//  Domain
//
//  Created by 최동호 on 7/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Foundation

public struct SchoolDataResponse: Decodable {
    public let data: [SchoolData]
    
    public init(data: [SchoolData]) {
        self.data = data
    }
}


