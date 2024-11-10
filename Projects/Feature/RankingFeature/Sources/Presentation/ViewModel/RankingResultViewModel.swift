//
//  RankingResultViewModel.swift
//  RankingFeature
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Combine
import Domain
import Foundation

class RankingResultViewModel {
    @Injected(TournamentUseCase.self)
    public var tournamentUseCase: TournamentUseCase
    
    var state = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    let category: String
    let round: Int
    let tournamentNo: Int
    var tournamentResultList: [TournamentResultData] = []
    var tournamentResultSum: Int = 1
    
    init(
        category: String,
        round: Int,
        tournamentNo: Int
    ) {
        self.category = category
        self.round = round
        self.tournamentNo = tournamentNo
    }
}

extension RankingResultViewModel {
    func getTournamentResult() {
        tournamentUseCase.getTournamentResult(request: .init(tournamentNo: tournamentNo))
            .sink { [weak self] data in
                guard let self = self else { return }
                self.tournamentResultList = data
                self.tournamentResultSum = data.reduce(0) { $0 + $1.score }
                self.state.send()
            }
            .store(in: &cancellables)
    }
    
    
    func getPercentage(voteCount: Int) -> Double {
        Double(String(format: "%.1f", Double(voteCount) / Double(tournamentResultSum) * 100)) ?? 0.0
    }
}
