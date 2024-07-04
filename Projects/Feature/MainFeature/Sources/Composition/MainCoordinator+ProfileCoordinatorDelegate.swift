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
                           ReportPopoverCoordinatorDelegate,
                           ReportDialogCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
    }
    
    public func didSelectReportButton(childCoordinator: Coordinator) {
        didFinish(childCoordinator: childCoordinator)
        let reportDialogCoordinator = factory.makeReportDialogCoordinator(
            navigation: navigation,
            delegate: self)
        addChildCoordinatorStart(reportDialogCoordinator)
    }
    
    public func didReport(childCoordinator: Coordinator) {
        didFinish(childCoordinator: childCoordinator)

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
        
        navigation.present(
            coordinator.navigation.rootViewController,
            animated: false)
    }
}
