//
//  ExistingUserLoginDialogViewController.swift
//  ATeen
//
//  Created by phang on 6/7/24.
//

import UIKit

protocol ExistingUserLoginDialogViewControllerCoordinator: AnyObject {
    func navigateToMainViewController()
}

final class ExistingUserLoginDialogViewController: CustomTwoButtonDialogViewController {
    private var coordinator: ExistingUserLoginDialogViewControllerCoordinator?
    
    init(
        coordinator: ExistingUserLoginDialogViewControllerCoordinator,
        dialogImage: UIImage? = nil,
        dialogTitle: String? = AppLocalized.existingUserDialogTitle,
        titleColor: UIColor = .black,
        titleNumberOfLine: Int = 1,
        titleFont: UIFont = .customFont(forTextStyle: .callout, weight: .bold),
        dialogMessage: String = AppLocalized.existingUserDialogMessage,
        messageColor: UIColor = .gray02,
        messageNumberOfLine: Int = 1,
        messageFont: UIFont = .customFont(forTextStyle: .footnote, weight: .regular),
        leftButtonText: String = AppLocalized.noButton,
        leftButtonColor: UIColor = .gray01,
        rightButtonText: String = AppLocalized.okGoodButton,
        rightButtonColor: UIColor = .main
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
    override func clickLeftButton(_ sender: UIButton) {
        super.clickLeftButton(sender)
        // TODO: 로그인 안된 상태로 메인화면 이동
        print("로그인 X")
        coordinator?.navigateToMainViewController()
    }
    
    override func clickRightButton(_ sender: UIButton) {
        super.clickRightButton(sender)
        // TODO: 로그인 상태로 메인화면 이동
        print("로그인 O")
        coordinator?.navigateToMainViewController()
    }
}
