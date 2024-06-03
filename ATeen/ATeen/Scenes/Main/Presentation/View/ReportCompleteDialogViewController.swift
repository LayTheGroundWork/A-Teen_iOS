//
//  ReportCompleteDialogViewController.swift
//  ATeen
//
//  Created by phang on 6/2/24.
//

import UIKit

protocol ReportCompleteDialogViewControllerCoordinator: AnyObject {
    func didFinish()
}

final class ReportCompleteDialogViewController: CustomConfirmDialogViewController {
    private weak var coordinator: ReportCompleteDialogViewControllerCoordinator?
    
    // MARK: - Life Cycle
    init(
        coordinator: ReportCompleteDialogViewControllerCoordinator,
        dialogTitle: String? = "신고가 완료되었습니다.",
        titleColor: UIColor = .black,
        titleNumberOfLine: Int = 1,
        titleFont: UIFont = .customFont(forTextStyle: .callout, weight: .bold),
        dialogMessage: String =  """
                                해당 프로필은 oo님에게
                                더이상 표시되지 않아요
                                """,
        messageColor: UIColor = .gray02,
        messageNumberOfLine: Int = 2,
        messageFont: UIFont = .customFont(forTextStyle: .footnote, weight: .regular),
        buttonText: String = "알겠어요!",
        buttonColor: UIColor = .main
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
        coordinator?.didFinish()
    }
}
