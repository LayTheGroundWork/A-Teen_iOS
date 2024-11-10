//
//  TournamentServiceImp.swift
//  Data
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import Domain
import Foundation

public struct TournamentServiceImp: TournamentService {
    private let auth: Auth
    private let tournamentSearchRepository: TournamentSearchRepository
    private let tournamentResultRepository: TournamentResultRepository
    private let thisWeekParticipantsRepository: ThisWeekParticipantsRepository
    private let tournamentVoteRepository: TournamentVoteRepository
    private let reissueRepository: ReissueRepository

    public init(
        auth: Auth,
        tournamentSearchRepository: TournamentSearchRepository,
        tournamentResultRepository: TournamentResultRepository,
        thisWeekParticipantsRepository: ThisWeekParticipantsRepository,
        tournamentVoteRepository: TournamentVoteRepository,
        reissueRepository: ReissueRepository
    ) {
        self.auth = auth
        self.tournamentSearchRepository = tournamentSearchRepository
        self.tournamentResultRepository = tournamentResultRepository
        self.thisWeekParticipantsRepository = thisWeekParticipantsRepository
        self.tournamentVoteRepository = tournamentVoteRepository
        self.reissueRepository = reissueRepository
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
            switch error.localizedDescription {
            case AppLocalized.expiredToken:
                guard let newToken = await reissueToken() else {
                    auth.logOut()
                    return (nil, error.localizedDescription)
                }
                return await getThisWeekParticipants(request: .init(
                    authorization: newToken,
                    category: request.category))
            default:
                return (nil, error.localizedDescription)
            }
        }
    }
    
    public func tournamentVote(request: TournamentVoteRequest) async -> String? {
        let response = await tournamentVoteRepository.tournamentVote(request: request)
        
        switch response {
        case .success(let response):
            return response.data
        case .failure(let error):
            switch error.localizedDescription {
            case AppLocalized.expiredToken:
                guard let newToken = await reissueToken() else {
                    auth.logOut()
                    return nil
                }
                return await tournamentVote(request: .init(
                    authorization: newToken,
                    tournamentNo: request.tournamentNo,
                    participantIdsOrderByRank: request.participantIdsOrderByRank))
            default:
                return nil
            }
        }
    }
    
    public func getAuthToken() -> String? {
        return auth.getAccessToken()
    }
 
    private func reissueToken() async -> String? {
        guard let token = auth.getAccessToken(),
              let refresh = auth.getRefreshToken() else { return nil }
        let response = await reissueRepository.reissueToken(request: .init(authorization: token, refresh: refresh))
        
        switch response {
        case .success(let response):
            return setTokens(response: response.0)
        case .failure(_):
            return nil
        }
    }
    
    private func setTokens(response: HTTPURLResponse) -> String? {
        guard let accessToken = response.value(forHTTPHeaderField: "authorization"),
              let refreshToken = response.value(forHTTPHeaderField: "refresh") else { return nil }

        auth.setAccessToken(accessToken)
        auth.setRefreshToken(refreshToken)
        return accessToken
    }
}
