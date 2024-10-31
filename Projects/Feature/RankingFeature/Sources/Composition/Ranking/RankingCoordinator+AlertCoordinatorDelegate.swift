//
//  RankingCoordinator+AlertCoordinatorDelegate.swift
//  RankingFeature
//
//  Created by 노주영 on 7/4/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension RankingCoordinator: AlertCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator, selectIndex: Int) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
        
        guard let factory = factory as? RankingFactoryImp else { return }
        switch selectIndex {
        case 1:
            let tournamentCoordinator = factory.makeTournamentCoordinator(
                navigation: navigation,
                delegate: self,
                coordinatorProvider: coordinatorProvider,
                category: factory.viewModel.voteCategory,
                participantList: factory.viewModel.thisWeekParticipantList)
            addChildCoordinatorStart(tournamentCoordinator)
        default:
            break
        }
    }
}
