//
//  TournamentViewModel.swift
//  RankingFeature
//
//  Created by 노주영 on 10/31/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Domain
import Foundation

class TournamentViewModel {
    var category: String
    var currentMatch: Int = 1
    var currentRound: TournamentRoundType = .roundOf16
    var participantList: [TournamentParticipantData]
    var loseParticipantList: [String] = []
    var voteResultList: [String] = []
    var winner: TournamentParticipantData?
    
    init(
        category: String,
        participantList: [TournamentParticipantData]
    ) {
        self.category = category
        self.participantList = participantList
    }
}

extension TournamentViewModel {
    func saveLoseParticipant(tournamentParticipant: TournamentParticipantData) {
        loseParticipantList.append(tournamentParticipant.userId)
    }
    
    func removeLoseParticipant() {
        loseParticipantList.forEach { id in
            if let index = participantList.firstIndex(where: { $0.userId == id}) {
                if loseParticipantList.count <= 2 {
                    voteResultList.append(participantList[index].userId)
                }
                participantList.remove(at: index)
            }
        }
        loseParticipantList.removeAll()
        
        if participantList.count == 1 {
            editVoteResult()
        }
    }
    
    func editVoteResult() {
        winner = participantList[0]
        voteResultList.append(participantList[0].userId)
        voteResultList.reverse()
    }
    
    func changeRound() -> Int? {
        removeLoseParticipant()
        switch currentRound {
        case .roundOf16:
            currentRound = .roundOf8
            return 1
        case .roundOf8:
            currentRound = .semifinals
            return 2
        case .semifinals:
            currentRound = .final
            return 3
        case .final:
            currentRound = .end
            return 4
        case .end:
            return nil
        }
    }
    
    func compareCurrentValues() -> Bool {
        if currentMatch == currentRound.matches {
            currentMatch = 1
            return true
        } else {
            self.currentMatch += 1
            return false
        }
    }
    
    func getUserAge(userBirth: String) -> Int {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        guard let currentYear = Int(dateFormatter.string(from: currentDate)),
              let birthYearString = userBirth.components(separatedBy: "-").first,
              let birthYear = Int(birthYearString)
        else { return 0 }
        
        return currentYear - birthYear + 1
    }
}
