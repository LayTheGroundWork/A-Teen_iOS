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

    private var cancellables = Set<AnyCancellable>()
    
    var state = PassthroughSubject<RankingStateController, Never>()
    var tournamentList: [TournamentSearchData] = []
    var thisWeekParticipantList: [TournamentParticipantData] = []
    var tournamentIndex: Int = 0
}

extension RankingViewModel {
    func searchTournamentList() {
        tournamentUseCase.searchTournament()
            .sink { [weak self] data in
                guard let self = self else { return }
                self.tournamentList = data
                print(self.tournamentList)
                self.state.send(.searchTournamentListSuccess)
            }
            .store(in: &cancellables)
    }
    
    func getThisWeekParticipantList(category: String) {
        guard let token = tournamentUseCase.getAuthToken(),
              let index = tournamentList.firstIndex(where: { $0.category == category })
        else {
            state.send(.openLoginSheet)
            return
        }
        tournamentIndex = index
        tournamentUseCase.getThisWeekParticipants(
            request: .init(
                authorization: token,
                category: changeCategoryName(tournamentList[tournamentIndex].category))
        )
        .sink { [weak self] (data, message) in
            guard let self = self else { return }
            
            if let data = data {
                self.thisWeekParticipantList = data.shuffled()
                self.state.send(.getThisWeekParticipantsSuccess)
            } else {
                switch message {
                case AppLocalized.expiredToken:
                    self.state.send(.openLoginSheet)
                case AppLocalized.participatedTournament:
                    self.state.send(.alreadyParticipatedTournament)
                default:
                    break
                }
            }
        }
        .store(in: &cancellables)
    }
    
    private func changeCategoryName(_ category: String) -> String {
        switch category {
        case "뷰티": return "BEAUTY"
        case "운동": return "SPORT"
        case "공부": return "STUDY"
        case "예술": return "ART"
        case "게임": return "GAME"
        case "기타": return "ETC"
        default: return ""
        }
    }
}
