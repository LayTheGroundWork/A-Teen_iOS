//
//  AlertFactory.swift
//  AlertFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

public protocol AlertFactory {
    func makeOneButtonDialogViewController(
        dialogData: CustomDialog,
        coordinator: AlertViewControllerCoordinator
    ) -> UIViewController
    
    func makeTwoButtonDialogViewController(
        dialogData: CustomDialog,
        coordinator: AlertViewControllerCoordinator
    ) -> UIViewController
}

public final class AlertFactoryImp: AlertFactory {
    
    public init() { }
    
    public func makeOneButtonDialogViewController(
        dialogData: CustomDialog,
        coordinator: AlertViewControllerCoordinator
    ) -> UIViewController {
        let controller = CustomConfirmDialogViewController(
            dialogTitle: dialogData.dialogTitle,
            titleColor: dialogData.titleColor,
            titleNumberOfLine: dialogData.titleNumberOfLine,
            titleFont: dialogData.titleFont,
            dialogMessage: dialogData.dialogMessage,
            messageColor: dialogData.messageColor,
            messageNumberOfLine: dialogData.messageNumberOfLine,
            messageFont: dialogData.messageFont,
            buttonText: dialogData.buttonText,
            buttonColor: dialogData.buttonColor,
            coordinator: coordinator
        )
        return controller
    }
    
    public func makeTwoButtonDialogViewController(
        dialogData: CustomDialog,
        coordinator: AlertViewControllerCoordinator
    ) -> UIViewController {
        let controller = CustomTwoButtonDialogViewController(
            dialogImage: dialogData.dialogImage ?? UIImage(),
            dialogTitle: dialogData.dialogTitle,
            titleColor: dialogData.titleColor,
            titleNumberOfLine: dialogData.titleNumberOfLine,
            titleFont: dialogData.titleFont,
            dialogMessage: dialogData.dialogMessage,
            messageColor: dialogData.messageColor,
            messageNumberOfLine: dialogData.messageNumberOfLine,
            messageFont: dialogData.messageFont,
            leftButtonText: dialogData.buttonText,
            leftButtonColor: dialogData.buttonColor,
            rightButtonText: dialogData.secondButtonText ?? "확인",
            rightButtonColor: dialogData.secondButtonColor ?? DesignSystemAsset.mainColor.color, 
            coordinator: coordinator
        )
        return controller
    }
}