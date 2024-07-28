//
//  ChatRoomFactory.swift
//  ChatFeature
//
//  Created by 김명현 on 7/22/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

public protocol ChatRoomFactory {
    func makeChatRoomViewController(coordinator: ChatRoomViewControllerCoordinator) -> UIViewController
}

public struct ChatRoomFactoryImp: ChatRoomFactory {
    var userID: ChatModel
    
    public init (userID: ChatModel) {
        self.userID = userID
    }
    
    public func makeChatRoomViewController(coordinator: ChatRoomViewControllerCoordinator) -> UIViewController {
        let controller = ChatRoomViewController(partnerName: userID.name, coordinator: coordinator)
        return controller
    }
}
