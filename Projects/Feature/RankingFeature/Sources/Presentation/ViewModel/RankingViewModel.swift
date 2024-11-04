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
    @Injected(Auth.self)
    public var auth: Auth
    
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
        guard let token = auth.getAccessToken(),
              let chageCategory = changeCategoryName(category: category),
              auth.isSessionActive
        else {
            
            
            return
        }
        
        tournamentUseCase.getThisWeekParticipants(
            request: .init(
                authorization: token,
                category: chageCategory)
        )
        .sink { [weak self] (data, message) in
            guard let self = self else { return }
            
            if let data = data {
                self.thisWeekParticipantList = data.shuffled()
                self.voteCategory = category
                self.state.send(.getThisWeekParticipantsSuccess)
            } else {
                switch message {
                case AppLocalized.expiredToken:
                    // TODO: refresh token 요청 코드
                    print("refresh")
                case AppLocalized.participatedTournament:
                    print("결과창 이동")
                    // TODO: 최종결과창 이동
                default:
                    break
                }
            }
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
