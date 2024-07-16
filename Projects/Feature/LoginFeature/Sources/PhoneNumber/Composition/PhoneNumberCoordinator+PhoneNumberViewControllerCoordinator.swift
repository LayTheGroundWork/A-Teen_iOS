//
//  PhoneNumberCoordinator+PhoneNumberViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import Common
import DesignSystem
import FeatureDependency
import UIKit

extension PhoneNumberCoordinator: PhoneNumberViewControllerCoordinator {
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func openVerificationCompleteDialog() {
        let coordinator = coordinatorProvider.makeAlertCoordinator(
            dialogType: .oneButton,
            delegate: self,
            dialogData: CustomDialog(
                dialogImage: UIImage(),
                dialogTitle: AppLocalized.verificationCompleteDialogTitle,
                titleColor: .black,
                titleNumberOfLine: 1,
                titleFont: .customFont(forTextStyle: .callout, weight: .bold),
                dialogMessage: AppLocalized.verificationCompleteDialogMessage,
                messageColor: DesignSystemAsset.gray02.color,
                messageNumberOfLine: 2,
                messageFont: .customFont(forTextStyle: .footnote, weight: .regular),
                buttonText: AppLocalized.okGoodButton,
                buttonColor: .black,
                secondButtonText: nil,
                secondButtonColor: nil))
        addChildCoordinatorStart(coordinator)
        
        navigation.present(
            coordinator.navigation.rootViewController,
            animated: false)
        
        // 이후 화면 이동
        coordinator.navigation.dismissNavigation = { [weak self] in
            guard let self = self else { return }
            let termsOfUseCoordinator = factory.makeTermsOfUseCoordinator(
                phoneNumber: viewModel.phoneNumber,
                navigation: navigation,
                childCoordinators: childCoordinators,
                delegate: self)
            addChildCoordinatorStart(termsOfUseCoordinator)
        }
    }
    
    public func openExistingUserLoginDialog() {
        let coordinator = coordinatorProvider.makeAlertCoordinator(
            dialogType: .twoButton,
            delegate: self,
            dialogData: CustomDialog(
                dialogImage: UIImage(),
                dialogTitle: AppLocalized.existingUserDialogTitle,
                titleColor: .black,
                titleNumberOfLine: 1,
                titleFont: .customFont(forTextStyle: .callout, weight: .bold),
                dialogMessage: AppLocalized.existingUserDialogMessage,
                messageColor: DesignSystemAsset.gray02.color,
                messageNumberOfLine: 1,
                messageFont: .customFont(forTextStyle: .footnote, weight: .regular),
                buttonText: AppLocalized.noButton,
                buttonColor: DesignSystemAsset.gray01.color,
                secondButtonText: AppLocalized.okGoodButton,
                secondButtonColor: DesignSystemAsset.mainColor.color))
        addChildCoordinatorStart(coordinator)
        
        navigation.present(
            coordinator.navigation.rootViewController,
            animated: false)
    }
    
    public func openInValidCodeNumberDialog() {
        let coordinator = coordinatorProvider.makeAlertCoordinator(
            dialogType: .oneButton,
            delegate: self,
            dialogData: CustomDialog(
                dialogImage: UIImage(),
                dialogTitle: AppLocalized.invalidCodeNumberDialogTitle,
                titleColor: .black,
                titleNumberOfLine: 1,
                titleFont: .customFont(forTextStyle: .callout, weight: .bold),
                dialogMessage: .empty,
                messageColor: DesignSystemAsset.gray02.color,
                messageNumberOfLine: 2,
                messageFont: .customFont(forTextStyle: .footnote, weight: .regular),
                buttonText: AppLocalized.okButton,
                buttonColor: .black,
                secondButtonText: nil,
                secondButtonColor: nil))
        addChildCoordinatorStart(coordinator)
        
        navigation.present(
            coordinator.navigation.rootViewController,
            animated: false)
    }
}
