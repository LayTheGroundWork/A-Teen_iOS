//
//  MyPageDTO.swift
//  Data
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

struct MyPageDTO: Decodable {
    public let status: Int
    public let data: MyPageData
    public let message: String
}

extension MyPageDTO {
    func toDomain() -> MyPageResponse {
        .init(data: data)
    }
}
