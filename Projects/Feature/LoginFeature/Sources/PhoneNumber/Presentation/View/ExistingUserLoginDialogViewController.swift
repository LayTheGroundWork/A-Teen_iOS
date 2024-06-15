//
//  ExistingUserLoginDialogViewController.swift
//  ATeen
//
//  Created by phang on 6/7/24.
//

import Common
import DesignSystem
import UIKit

public protocol ExistingUserLoginDialogViewControllerCoordinator: AnyObject {
    func navigateToMainViewController()
}

public final class ExistingUserLoginDialogViewController: CustomTwoButtonDialogViewController {
    private var coordinator: ExistingUserLoginDialogViewControllerCoordinator?
    
    public init(
        coordinator: ExistingUserLoginDialogViewControllerCoordinator,
        dialogImage: UIImage? = nil,
        dialogTitle: String? = AppLocalized.existingUserDialogTitle,
        titleColor: UIColor = .black,
        titleNumberOfLine: Int = 1,
        titleFont: UIFont = .customFont(forTextStyle: .callout, weight: .bold),
        dialogMessage: String = AppLocalized.existingUserDialogMessage,
        messageColor: UIColor = DesignSystemAsset.gray02.color,
        messageNumberOfLine: Int = 1,
        messageFont: UIFont = .customFont(forTextStyle: .footnote, weight: .regular),
        leftButtonText: String = AppLocalized.noButton,
        leftButtonColor: UIColor = DesignSystemAsset.gray01.color,
        rightButtonText: String = AppLocalized.okGoodButton,
        rightButtonColor: UIColor = DesignSystemAsset.mainColor.color
    ) {
        self.coordinator = coordinator
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
        // TODO: 로그인 안된 상태로 메인화면 이동
        print("로그인 X")
        coordinator?.navigateToMainViewController()
    }
    
    public override func clickRightButton(_ sender: UIButton) {
        super.clickRightButton(sender)
        // TODO: 로그인 상태로 메인화면 이동
        print("로그인 O")
        coordinator?.navigateToMainViewController()
    }
}
