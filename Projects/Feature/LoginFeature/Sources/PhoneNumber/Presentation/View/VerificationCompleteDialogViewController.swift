//
//  VerificationCompleteDialogViewController.swift
//  ATeen
//
//  Created by phang on 6/7/24.
//

import Common
import DesignSystem
import UIKit

public protocol VerificationCompleteDialogViewControllerCoordinator: AnyObject {
    func didSelectOKButton()
}

public final class VerificationCompleteDialogViewController: CustomConfirmDialogViewController {
    private weak var coordinator: VerificationCompleteDialogViewControllerCoordinator?
    
    init(
        coordinator: VerificationCompleteDialogViewControllerCoordinator,
        dialogTitle: String? = AppLocalized.verificationCompleteDialogTitle,
        titleColor: UIColor = .black,
        titleNumberOfLine: Int = 1,
        titleFont: UIFont = .customFont(forTextStyle: .callout, weight: .bold),
        dialogMessage: String = AppLocalized.verificationCompleteDialogMessage,
        messageColor: UIColor = DesignSystemAsset.gray02.color,
        messageNumberOfLine: Int = 2,
        messageFont: UIFont = .customFont(forTextStyle: .footnote, weight: .regular),
        buttonText: String = AppLocalized.okGoodButton,
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
    public override func clickConfirmButton(_ sender: UIButton) {
        super.clickConfirmButton(sender)
        coordinator?.didSelectOKButton()
    }
}
