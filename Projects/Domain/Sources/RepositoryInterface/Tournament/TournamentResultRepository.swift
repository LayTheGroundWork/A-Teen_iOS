//
//  TournamentResultRepository.swift
//  Domain
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol TournamentResultRepository {
    func getTournamentResult(request: TournamentResultRequest) async -> Result<TournamentResultResponse, Error>
}
