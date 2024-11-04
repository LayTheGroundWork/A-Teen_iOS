//
//  ThisWeekParticipantsDTO.swift
//  Data
//
//  Created by 노주영 on 10/31/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct ThisWeekParticipantsDTO: Decodable {
    public let status: Int
    public let data: [TournamentParticipantData]
    public let message: String
}

extension ThisWeekParticipantsDTO {
    func toDomain() -> ThisWeekParticipantsResponse {
        .init(data: data, message: message)
    }
}

