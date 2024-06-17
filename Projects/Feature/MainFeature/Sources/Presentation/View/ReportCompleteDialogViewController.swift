//
//  ReportCompleteDialogViewController.swift
//  ATeen
//
//  Created by phang on 6/2/24.
//

import Common
import DesignSystem
import UIKit

public protocol ReportCompleteDialogViewControllerCoordinator: AnyObject {
    func didFinish()
}

public final class ReportCompleteDialogViewController: CustomConfirmDialogViewController {
    private weak var coordinator: ReportCompleteDialogViewControllerCoordinator?
    
    // MARK: - Life Cycle
    public init(
        coordinator: ReportCompleteDialogViewControllerCoordinator,
        dialogTitle: String? = AppLocalized.reportCompleteDialogTitle,
        titleColor: UIColor = .black,
        titleNumberOfLine: Int = 1,
        titleFont: UIFont = .customFont(forTextStyle: .callout, weight: .bold),
        dialogMessage: String = """
                                해당 프로필은 oo님에게
                                더이상 표시되지 않아요
                                """,
        messageColor: UIColor = DesignSystemAsset.gray02.color,
        messageNumberOfLine: Int = 2,
        messageFont: UIFont = .customFont(forTextStyle: .footnote, weight: .regular),
        buttonText: String = AppLocalized.okButton,
        buttonColor: UIColor = DesignSystemAsset.mainColor.color
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
        coordinator?.didFinish()
    }
}
