//
//  VerificationCompleteDialogViewController.swift
//  ATeen
//
//  Created by phang on 6/7/24.
//

import UIKit

protocol VerificationCompleteDialogViewControllerCoordinator: AnyObject {
    func didSelectOKButton()
}

final class VerificationCompleteDialogViewController: CustomConfirmDialogViewController {
    private weak var coordinator: VerificationCompleteDialogViewControllerCoordinator?
    
    init(
        coordinator: VerificationCompleteDialogViewControllerCoordinator,
        dialogTitle: String? = "인증이 완료되었어요!",
        titleColor: UIColor = .black,
        titleNumberOfLine: Int = 1,
        titleFont: UIFont = .customFont(forTextStyle: .callout, weight: .bold),
        dialogMessage: String = """
                                A-TEEN에 정보를 입력하여
                                가입을 마저 완료해보세요.
                                """,
        messageColor: UIColor = .gray02,
        messageNumberOfLine: Int = 2,
        messageFont: UIFont = .customFont(forTextStyle: .footnote, weight: .regular),
        buttonText: String = "좋아요!",
        buttonColor: UIColor = .black
    ) {
        self.coordinator = coordinator
        super.init(
            dialogTitle: dialogTitle,
            dialogMessage: dialogMessage,
            messageNumberOfLine: messageNumberOfLine,
            buttonText: buttonText,
            buttonColor: buttonColor
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    override func clickConfirmButton(_ sender: UIButton) {
        super.clickConfirmButton(sender)
        coordinator?.didSelectOKButton()
    }
}
