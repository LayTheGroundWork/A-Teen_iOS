//
//  RankingCoordinator+RankingViewControllerCoordinator.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import FeatureDependency
import UIKit

extension RankingCoordinator: RankingViewControllerCoordinator {
    public func didTapVoteButton(sector: String) {
        self.sector = sector
        let coordinator = coordinatorProvider.makeAlertCoordinator(
            dialogType: .twoButton,
            delegate: self,
            dialogData: CustomDialog(
                dialogImage: UIImage(),
                dialogTitle: "\(sector) 투표에 참여하시겠어요?",
                titleColor: .black,
                titleNumberOfLine: 1,
                titleFont: .customFont(forTextStyle: .callout, weight: .bold),
                dialogMessage: "투표 설명이 들어갈 위치",
                messageColor: DesignSystemAsset.gray02.color,
                messageNumberOfLine: 1,
                messageFont: .customFont(forTextStyle: .footnote, weight: .regular),
                buttonText: "다음에 할게요",
                buttonColor: DesignSystemAsset.gray01.color,
                secondButtonText: "네, 참여할래요!",
                secondButtonColor: DesignSystemAsset.mainColor.color))
        addChildCoordinatorStart(coordinator)
        
        navigation.present(
            coordinator.navigation.rootViewController,
            animated: false)
    }
    
    public func didTapRankingCollectionViewCell(
        sector: String,
        session: String
    ) {
        let rankingResultCoordinator = factory.makeRankingResultCoordinator(
            navigation: navigation,
            delegate: self,
            withAnimation: true,
            sector: sector,
            session: session)
        addChildCoordinatorStart(rankingResultCoordinator)
    }
}
