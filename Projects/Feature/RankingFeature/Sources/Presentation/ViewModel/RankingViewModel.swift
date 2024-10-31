//
//  RankingViewModel.swift
//  RankingFeature
//
//  Created by 노주영 on 10/30/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Core
import Combine
import Domain
import Foundation

class RankingViewModel {
    @Injected(TournamentUseCase.self)
    public var tournamentUseCase: TournamentUseCase
    
    var state = PassthroughSubject<RankingStateController, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    var tournamentList: [TournamentSearchData] = []
    var thisWeekParticipantList: [TournamentParticipantData] = []
    var voteCategory: String = ""
}

extension RankingViewModel {
    func searchTournamentList() {
        tournamentUseCase.searchTournament()
            .sink { [weak self] data in
                guard let self = self else { return }
                self.tournamentList = data
                self.state.send(.searchTournamentListSuccess)
            }
            .store(in: &cancellables)
    }
    
    func getThisWeekParticipantList(category: String) {
        guard let chageCategory = changeCategoryName(category: category) else { return }
        tournamentUseCase.getThisWeekParticipants(request: .init(category: chageCategory))
            .sink { [weak self] data in
                guard let self = self else { return }
                self.thisWeekParticipantList = data.shuffled()
                self.voteCategory = category
                self.state.send(.getThisWeekParticipantsSuccess)
            }
            .store(in: &cancellables)
    }
    
    func changeCategoryName(category: String) -> String? {
        switch category {
        case "뷰티": "BEAUTY"
        case "운동": "SPORT"
        case "공부": "STUDY"
        case "예술": "ART"
        case "게임": "GAME"
        case "기타": "ETC"
        default: nil
        }
    }
}
