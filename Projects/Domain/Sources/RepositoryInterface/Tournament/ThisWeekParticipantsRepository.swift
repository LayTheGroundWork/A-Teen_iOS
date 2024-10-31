//
//  ThisWeekParticipantsRepository.swift
//  Domain
//
//  Created by 노주영 on 10/31/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol ThisWeekParticipantsRepository {
    func getThisWeekParticipants(request: ThisWeekParticipantsRequest) async -> Result<ThisWeekParticipantsResponse, Error>
}
