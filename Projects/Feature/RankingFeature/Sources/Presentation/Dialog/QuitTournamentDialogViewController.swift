//
//  QuitTournamentDialogViewController.swift
//  RankingFeature
//
//  Created by phang on 6/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import DesignSystem
import UIKit

protocol QuitTournamentDialogViewControllerDelegate: AnyObject {
    func endTournament()
}

final class QuitTournamentDialogViewController: CustomTwoButtonDialogViewController {
    weak var delegate: QuitTournamentDialogViewControllerDelegate?
    
    // MARK: - Life Cycle
    public init(
        delegate: QuitTournamentDialogViewControllerDelegate,
        dialogImage: UIImage? = nil,
        dialogTitle: String? = "정말로 그만 두시겠어요?",
        titleColor: UIColor = UIColor.black,
        titleNumberOfLine: Int = 1,
        titleFont: UIFont = .customFont(forTextStyle: .callout, weight: .bold),
        dialogMessage: String = "여기서 그만 두면\n처음부터 투표를 다시 해야해요!",
        messageColor: UIColor = DesignSystemAsset.gray02.color,
        messageNumberOfLine: Int = 2,
        messageFont: UIFont = .customFont(forTextStyle: .footnote, weight: .regular),
        leftButtonText: String = "그만 둘래요",
        leftButtonColor: UIColor = DesignSystemAsset.gray01.color,
        rightButtonText: String = "마저 할게요!",
        rightButtonColor: UIColor = DesignSystemAsset.mainColor.color
    ) {
        self.delegate = delegate
        super.init(
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
        // TODO: - 다이얼로그 닫기 & 토너먼트 닫기
//        self.dismiss(animated: false)
//        delegate?.endTournament()
    }
    
    public override func clickRightButton(_ sender: UIButton) {
        super.clickRightButton(sender)
        // TODO: - 다이얼로그 닫기
//        self.dismiss(animated: false)
    }
}
