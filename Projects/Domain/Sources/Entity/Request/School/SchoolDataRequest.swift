//
//  SchoolDataRequest.swift
//  Domain
//
//  Created by 최동호 on 7/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct SchoolDataRequest {
    public let schoolName: String
    
    public init(
        schoolName: String
    ) {
        self.schoolName = schoolName
    }
}
