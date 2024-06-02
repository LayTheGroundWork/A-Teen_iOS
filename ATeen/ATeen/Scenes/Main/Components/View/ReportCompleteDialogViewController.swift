//
//  ReportCompleteDialogViewController.swift
//  ATeen
//
//  Created by phang on 6/2/24.
//

import UIKit

final class ReportCompleteDialogViewController: CustomConfirmDialogViewController {
    // MARK: - Life Cycle
    override init(
        dialogTitle: String? = nil,
        titleColor: UIColor = .black,
        titleNumberOfLine: Int = 1,
        titleFont: UIFont = .customFont(forTextStyle: .callout, weight: .bold),
        dialogMessage: String,
        messageColor: UIColor = .gray02,
        messageNumberOfLine: Int,
        messageFont: UIFont = .customFont(forTextStyle: .footnote, weight: .regular),
        buttonText: String,
        buttonColor: UIColor
    ) {
        super.init(
            dialogTitle: "신고가 완료되었습니다.",
            dialogMessage: """
                        해당 프로필은 oo님에게
                        더이상 표시되지 않아요
                        """,
            messageNumberOfLine: 2,
            buttonText: "알겠어요!",
            buttonColor: .main
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
