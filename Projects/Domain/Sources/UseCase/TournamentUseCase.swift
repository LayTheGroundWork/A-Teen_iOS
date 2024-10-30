//
//  TournamentUseCase.swift
//  Domain
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Combine

public protocol TournamentUseCase {
    func searchTournament() -> AnyPublisher<[TournamentSearchData], Never>
    func getTournamentResult(request: TournamentResultRequest) -> AnyPublisher<[TournamentResultData], Never>
}
