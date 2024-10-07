//
//  ChatCoordinator+ChatViewControllerCoordinator.swift
//  ChatFeature
//
//  Created by 김명현 on 7/22/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import UIKit

extension ChatCoordinator: ChatViewControllerCoordinator {
    public func didTapCell(userID: ChatModel) {
        let coordinator = factory.makeChatRoomCoordinator(
            navigation: navigation,
            parentCoordinator: self,
            delegate: self,
            childCoordinators: childCoordinators,
            userID: userID,
            factoryProvider: factoryProvider,
            coordinatorProvider: coordinatorProvider)
        
        addChildCoordinatorStart(coordinator)
    }
    
    public func didTapLeaveButton(for indexPath: IndexPath) {
        let coordinator = coordinatorProvider.makeAlertCoordinator(
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
                secondButtonColor: .red)
        )
        
        addChildCoordinatorStart(coordinator)
        
        navigation.present(
            coordinator.navigation.rootViewController,
            animated: false)
    }
}
