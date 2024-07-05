//
//  AlertCoordinator.swift
//  AlertFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import UIKit

public final class AlertCoordinator: Coordinator {
    public let dialogType: AlertDialogType
    public var navigation: Navigation
    public let factory: AlertFactory
    var dialogData: CustomDialog
    weak var delegate: AlertCoordinatorDelegate?

    public init(
        dialogType: AlertDialogType,
        navigation: Navigation,
        factory: AlertFactory,
        dialogData: CustomDialog,
        delegate: AlertCoordinatorDelegate
    ) {
        self.dialogType = dialogType
        self.navigation = navigation
        self.factory = factory
        self.dialogData = dialogData
        self.delegate = delegate
    }
    
    public func start() {
        switch dialogType {
        case .oneButton:
            let controller = factory.makeOneButtonDialogViewController(
                dialogData: dialogData,
                coordinator: self
            )
            navigation.viewControllers = [controller]

        case .twoButton:
            let controller = factory.makeTwoButtonDialogViewController(
                dialogData: dialogData,
                coordinator: self
            )
            navigation.viewControllers = [controller]
        }
    }
}
