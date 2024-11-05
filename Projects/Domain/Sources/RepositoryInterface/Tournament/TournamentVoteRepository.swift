//
//  TournamentVoteRepository.swift
//  Domain
//
//  Created by 최동호 on 11/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol TournamentVoteRepository {
    func tournamentVote(request: TournamentVoteRequest) async -> Result<DefaultResponse, Error>
}
