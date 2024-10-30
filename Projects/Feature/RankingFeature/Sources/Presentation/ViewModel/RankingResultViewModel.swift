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
                
                if data.isEmpty {
                    //임시 데이터가 아직 서버에 없음
                    self.tournamentResultList = [
                        .init(rankerId: "", rankerNickName: "24, 48 데이터 없음", rank: 1, voteCount: 10, profileImageUrl: ""),
                        .init(rankerId: "", rankerNickName: "24, 48 데이터 없음", rank: 2, voteCount: 5, profileImageUrl: ""),
                        .init(rankerId: "", rankerNickName: "24, 48 데이터 없음", rank: 3, voteCount: 3, profileImageUrl: ""),
                        .init(rankerId: "", rankerNickName: "24, 48 데이터 없음", rank: 4, voteCount: 2, profileImageUrl: "")
                    ]
                    self.tournamentResultSum = self.tournamentResultList.reduce(0) { $0 + $1.voteCount }
                } else {
                    self.tournamentResultList = data
                    self.tournamentResultSum = data.reduce(0) { $0 + $1.voteCount }
                }
                self.state.send()
            }
            .store(in: &cancellables)
    }
    
    
    func getPercentage(voteCount: Int) -> Double {
        Double(String(format: "%.1f", Double(voteCount) / Double(tournamentResultSum) * 100)) ?? 0.0
    }
}
