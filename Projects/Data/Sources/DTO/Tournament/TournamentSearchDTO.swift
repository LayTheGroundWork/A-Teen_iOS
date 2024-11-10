//
//  TournamentSearchDTO.swift
//  Data
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct TournamentSearchDTO: Decodable {
    public let status: Int
    public let data: [TournamentSearchData]
    public let message: String
}

extension TournamentSearchDTO {
    func toDomain() -> TournamentSearchResponse {
        .init(data: data)
    }
}
