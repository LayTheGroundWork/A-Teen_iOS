//
//  CustomDialog.swift
//  Common
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

public struct CustomDialog {
    public var dialogImage: UIImage?
    public var dialogTitle: String
    public var titleColor: UIColor
    public var titleNumberOfLine: Int
    public var titleFont: UIFont
    public var dialogMessage: String?
    public var messageColor: UIColor?
    public var messageNumberOfLine: Int?
    public var messageFont: UIFont
    public var buttonText: String
    public var buttonColor: UIColor
    public var secondButtonText: String?
    public var secondButtonColor: UIColor?
    
    public init(
        dialogImage: UIImage?,
        dialogTitle: String,
        titleColor: UIColor,
        titleNumberOfLine: Int,
        titleFont: UIFont,
        dialogMessage: String?,
        messageColor: UIColor?,
        messageNumberOfLine: Int?,
        messageFont: UIFont,
        buttonText: String,
        buttonColor: UIColor,
        secondButtonText: String?,
        secondButtonColor: UIColor?
    ) {
        self.dialogImage = dialogImage
        self.dialogTitle = dialogTitle
        self.titleColor = titleColor
        self.titleNumberOfLine = titleNumberOfLine
        self.titleFont = titleFont
        self.dialogMessage = dialogMessage
        self.messageColor = messageColor
        self.messageNumberOfLine = messageNumberOfLine
        self.messageFont = messageFont
        self.buttonText = buttonText
        self.buttonColor = buttonColor
        self.secondButtonText = secondButtonText
        self.secondButtonColor = secondButtonColor
    }
}

