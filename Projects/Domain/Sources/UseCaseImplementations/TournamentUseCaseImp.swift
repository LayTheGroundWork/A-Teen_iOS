//
//  TournamentUseCaseImp.swift
//  Domain
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Combine

public struct TournamentUseCaseImp: TournamentUseCase {
    public let tournamentService: TournamentService
    
    public init(tournamentService: TournamentService) {
        self.tournamentService = tournamentService
    }
    
    public func searchTournament() -> AnyPublisher<[TournamentSearchData], Never> {
        Future { promise in
            Task {
                let data = await tournamentService.searchTournament()
                promise(.success(data))
            }
        }
        .eraseToAnyPublisher()
    }
}
