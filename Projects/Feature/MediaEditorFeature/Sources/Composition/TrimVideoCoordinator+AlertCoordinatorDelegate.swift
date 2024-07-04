//
//  TrimVideoCoordinator+AlertCoordinatorDelegate.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency

extension TrimVideoCoordinator: AlertCoordinatorDelegate {
    public func didFinish(childCoordinator: FeatureDependency.Coordinator, selectIndex: Int) {
        switch selectIndex {
        case 0:
            closeDialog(childCoordinator: childCoordinator)
        default:
            break
        }
    }
    
    private func closeDialog(childCoordinator: Coordinator) {
        // 다이얼로그 닫기
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
    }
}
