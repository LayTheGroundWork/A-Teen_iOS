//
//  TournamentCoordinator+TournamentViewControllerCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import FeatureDependency
import UIKit

extension TournamentCoordinator: TournamentViewControllerCoordinator {
    public func finishTournament(
        sector: String,
        session: String
    ) {
        delegate?.finishTournament(
            childCoordinator: self,
            sector: sector,
            session: session
        )
    }
    
    public func configTabbarState(view: RankingFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
    
    public func quitTournament() {
        delegate?.quitTournament(childCoordinator: self)
    }
    
    public func openQuitDialog() {
        let coordinator = coordinatorProvider.makeAlertCoordinator(
            dialogType: .twoButton,
            delegate: self,
            dialogData: CustomDialog(
                dialogImage: UIImage(),
                dialogTitle: "정말로 그만 두시겠어요?",
                titleColor: .black,
                titleNumberOfLine: 1,
                titleFont: .customFont(forTextStyle: .callout, weight: .bold),
                dialogMessage: "여기서 그만 두면\n처음부터 투표를 다시 해야해요!",
                messageColor: DesignSystemAsset.gray02.color,
                messageNumberOfLine: 2,
                messageFont: .customFont(forTextStyle: .footnote, weight: .regular),
                buttonText: "그만 둘래요",
                buttonColor: DesignSystemAsset.gray01.color,
                secondButtonText: "마저 할게요!",
                secondButtonColor: DesignSystemAsset.mainColor.color))
        addChildCoordinatorStart(coordinator)
        
        navigation.present(
            coordinator.navigation.rootViewController,
            animated: false)
    }
}
