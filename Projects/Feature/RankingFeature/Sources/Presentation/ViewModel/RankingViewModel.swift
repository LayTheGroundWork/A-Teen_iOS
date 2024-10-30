//
//  RankingViewModel.swift
//  RankingFeature
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Combine
import Domain
import Foundation

class RankingViewModel {
    @Injected(TournamentUseCase.self)
    public var tournamentUseCase: TournamentUseCase
    
    var state = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    var tournamentList: [TournamentSearchData] = []
}

extension RankingViewModel {
    func searchTournamentList() {
        tournamentUseCase.searchTournament()
            .sink { [weak self] data in
                guard let self = self else { return }
                self.tournamentList = data
                self.state.send()
            }
            .store(in: &cancellables)
    }
}
