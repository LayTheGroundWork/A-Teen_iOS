//
//  MainCoordinator+ProfileCoordinatorDelegate.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

import Common
import DesignSystem
import FeatureDependency
import UIKit

extension MainCoordinator: ProfileDetailCoordinatorDelegate,
                           ReportPopoverCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
        mainViewControllerDelegate?.reStartTimer()
    }
    
    public func didReport() {
        let coordinator = coordinatorProvider.makeAlertCoordinator(
            dialogType: .oneButton,
            delegate: self,
            dialogData: CustomDialog(
                dialogImage: UIImage(),
                dialogTitle: AppLocalized.reportCompleteDialogTitle,
                titleColor: .black,
                titleNumberOfLine: 1,
                titleFont: .customFont(forTextStyle: .callout, weight: .bold),
                dialogMessage: "해당 프로필은 oo님에게\n더이상 표시되지 않아요",
                messageColor: DesignSystemAsset.gray02.color,
                messageNumberOfLine: 2,
                messageFont: .customFont(forTextStyle: .footnote, weight: .regular),
                buttonText: AppLocalized.okButton,
                buttonColor: DesignSystemAsset.mainColor.color,
                secondButtonText: nil,
                secondButtonColor: nil))
        addChildCoordinatorStart(coordinator)
        
        navigation.present(coordinator.navigation.rootViewController, animated: false)
    }
}

extension MainCoordinator: AlertCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator, selectIndex: Int) {
        switch selectIndex {
        case 0:
            childCoordinator.navigation.dismissNavigation = nil
            removeChildCoordinator(childCoordinator)
            navigation.dismiss(animated: false)
        default:
            break
        }
    }
}

