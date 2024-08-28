//
//  TrimVideoCoordinator+TrimVideoViewControllerCoordinator.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVKit
import Common
import DesignSystem
import FeatureDependency

extension TrimVideoCoordinator: TrimVideoViewControllerCoordinator {
    public func didSelectCheckButton(asset: AVAsset, isPossible: Bool) {
        switch isPossible {
        case true:
            let coordinator = factory.makeSelectCategoryVideoCoordinator(
                navigation: navigation,
                childCoordinators: childCoordinators,
                delegate: self,
                selectAsset: asset)

            addChildCoordinatorStart(coordinator)
        case false:
            let coordinator = coordinatorProvider.makeAlertCoordinator(
                dialogType: .oneButton,
                delegate: self,
                dialogData:  CustomDialog(
                    dialogImage: UIImage(),
                    dialogTitle: AppLocalized.maxVideoTimeText,
                    titleColor: .black,
                    titleNumberOfLine: 1,
                    titleFont: .customFont(forTextStyle: .callout, weight: .bold),
                    dialogMessage: nil,
                    messageColor: nil,
                    messageNumberOfLine: nil,
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
    
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
}
