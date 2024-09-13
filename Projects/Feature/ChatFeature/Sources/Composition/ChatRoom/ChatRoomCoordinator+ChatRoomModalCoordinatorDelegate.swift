//
//  ChatRoomCoordinator+ChatRoomModalCoordinatorDelegate.swift
//  ChatFeature
//
//  Created by 김명현 on 8/7/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import UIKit


extension ChatRoomCoordinator: ChatRoomModalCoordinatorDelegate {
    public func didFinishChatRoomModal(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
    }
    
    public func didTappedReportButton(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
        
        let reportDialogCoordinator = coordinatorProvider.makeReportDialogCoordinator(navigation: navigation, delegate: self, childCoordinator: childCoordinators, dialogType: .chat)
        
        addChildCoordinatorStart(reportDialogCoordinator)
    }
    
    public func didTappedLeaveButton(childCoordinator: Coordinator) {
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
        
        let alertCoordinator = coordinatorProvider.makeAlertCoordinator(
            dialogType: .twoButton,
            delegate: self,
            dialogData: CustomDialog(
                dialogImage: nil,
                dialogTitle: "채팅방에서 나가시겠습니까?",
                titleColor: .black,
                titleNumberOfLine: 1,
                titleFont: UIFont.systemFont(ofSize: 16, weight: .bold),
                dialogMessage: nil,
                messageColor: .gray,
                messageNumberOfLine: 2,
                messageFont: UIFont.systemFont(ofSize: 14),
                buttonText: "취소",
                buttonColor: .gray,
                secondButtonText: "나가기",
                secondButtonColor: .red
            )
        )
        
        addChildCoordinatorStart(alertCoordinator)
        
        navigation.present(
            alertCoordinator.navigation.rootViewController,
            animated: false)
    }
    
}


