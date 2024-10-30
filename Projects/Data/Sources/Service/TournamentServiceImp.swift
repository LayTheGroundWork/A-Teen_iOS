//
//  TournamentServiceImp.swift
//  Data
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct TournamentServiceImp: TournamentService {
    private let tournamentSearchRepository: TournamentSearchRepository
    
    public init(tournamentSearchRepository: TournamentSearchRepository) {
        self.tournamentSearchRepository = tournamentSearchRepository
    }
    
    public func searchTournament() async -> [TournamentSearchData] {
        let response = await tournamentSearchRepository.searchTournament()
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(_):
            return []
        }
    }
}
