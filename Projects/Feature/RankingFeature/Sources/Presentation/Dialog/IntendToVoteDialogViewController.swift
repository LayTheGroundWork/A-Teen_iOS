//
//  IntendToVoteDialogViewController.swift
//  RankingFeature
//
//  Created by phang on 6/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import DesignSystem
import UIKit

protocol IntendToVoteDialogViewControllerCoordinator: AnyObject {
    func quitDialog()
    func didTapParticipateInVote()
}

final class IntendToVoteDialogViewController: CustomTwoButtonDialogViewController {
    let sector: String
    
    // MARK: - Private properties
    private weak var coordinator: IntendToVoteDialogViewControllerCoordinator?
    
    // MARK: - Life Cycle
    public init(
        sector: String,
        coordinator: IntendToVoteDialogViewControllerCoordinator,
        dialogImage: UIImage? = nil,
//        dialogImage: UIImage? = UIImage(named: "hrmi"),
        dialogTitle: String? = nil,
        titleColor: UIColor = UIColor.black,
        titleNumberOfLine: Int = 1,
        titleFont: UIFont = .customFont(forTextStyle: .callout, weight: .bold),
        dialogMessage: String = "투표 설명이 들어갈 위치",
        messageColor: UIColor = DesignSystemAsset.gray02.color,
        messageNumberOfLine: Int = 1,
        messageFont: UIFont = .customFont(forTextStyle: .footnote, weight: .regular),
        leftButtonText: String = "다음에 할게요",
        leftButtonColor: UIColor = DesignSystemAsset.gray01.color,
        rightButtonText: String = "네, 참여할래요!",
        rightButtonColor: UIColor = DesignSystemAsset.mainColor.color
    ) {
        let dialogTitle = dialogTitle ?? "\(sector) 투표에 참여하시겠어요?"
        
        self.sector = sector
        self.coordinator = coordinator
        
        super.init(
            dialogImage: dialogImage,
            dialogTitle: dialogTitle,
            titleNumberOfLine: titleNumberOfLine,
            dialogMessage: dialogMessage,
            messageNumberOfLine: messageNumberOfLine,
            leftButtonText: leftButtonText,
            leftButtonColor: leftButtonColor,
            rightButtonText: rightButtonText,
            rightButtonColor: rightButtonColor
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    public override func clickLeftButton(_ sender: UIButton) {
        super.clickLeftButton(sender)
        coordinator?.quitDialog()
    }
    
    public override func clickRightButton(_ sender: UIButton) {
        super.clickRightButton(sender)
        coordinator?.didTapParticipateInVote()
        // TODO: - 토너먼트 진행 화면 이동
//        let tournamentVC = TournamentViewController(sector: "뷰티")
//        
//        if let presentingVC = self.presentingViewController {
//            self.dismiss(animated: false) {
//                if let navigationController = presentingVC as? UINavigationController {
//                    navigationController.pushViewController(tournamentVC, animated: true)
//                } else {
//                    let navController = UINavigationController(rootViewController: tournamentVC)
//                    self.presentingViewController?.present(navController, animated: true)
//                }
//            }
//        }
    }
}
