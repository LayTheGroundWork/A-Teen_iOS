//
//  ChatRoomModalFactory.swift
//  ChatFeature
//
//  Created by 김명현 on 8/7/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import FeatureDependency
import UIKit


public protocol ChatRoomModalFactory {
    func makeChatRoomModalViewController(coordinator: ChatRoomModalViewControllerCoordinator) -> UIViewController
}

public struct ChatRoomModalFactoryImp: ChatRoomModalFactory {
    public init() {}
    
    public func makeChatRoomModalViewController(coordinator: ChatRoomModalViewControllerCoordinator) -> UIViewController {
        let controller = ChatRoomModalViewController(coordinator: coordinator)
        
        return controller
    }
}
