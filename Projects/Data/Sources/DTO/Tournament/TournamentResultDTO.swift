//
//  TournamentResultDTO.swift
//  Data
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct TournamentResultDTO: Decodable {
    public let status: Int
    public let data: [TournamentResultData]
    public let message: String
}

extension TournamentResultDTO {
    func toDomain() -> TournamentResultResponse {
        .init(data: data)
    }
}
