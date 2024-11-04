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
    private let tournamentResultRepository: TournamentResultRepository
    private let thisWeekParticipantsRepository: ThisWeekParticipantsRepository
    
    public init(
        tournamentSearchRepository: TournamentSearchRepository,
        tournamentResultRepository: TournamentResultRepository,
        thisWeekParticipantsRepository: ThisWeekParticipantsRepository
    ) {
        self.tournamentSearchRepository = tournamentSearchRepository
        self.tournamentResultRepository = tournamentResultRepository
        self.thisWeekParticipantsRepository = thisWeekParticipantsRepository
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
    
    public func getTournamentResult(request: TournamentResultRequest) async -> [TournamentResultData] {
        let response = await tournamentResultRepository.getTournamentResult(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(_):
            return []
        }
    }
    
    public func getThisWeekParticipants(request: ThisWeekParticipantsRequest) async -> ([TournamentParticipantData]?, String) {
        let response = await thisWeekParticipantsRepository.getThisWeekParticipants(request: request)
        
        switch response {
        case .success(let response):
            return (response.data, response.message)
        case .failure(let error):
            return (nil, error.localizedDescription)
        }
    }
}
