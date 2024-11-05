//
//  TournamentVoteDTO.swift
//  Data
//
//  Created by 최동호 on 11/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct TournamentVoteDTO: Decodable {
    public let status: Int
    public let data: String?
    public let message: String
}

extension TournamentVoteDTO {
    func toDomain() -> DefaultResponse {
        .init(status: status, data: data, message: message)
    }
}
