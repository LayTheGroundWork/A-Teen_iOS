//
//  ChatFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

public protocol ChatFactory {
    func makeMainChatViewController(coordinator: MainChatViewControllerCoordinator) -> UIViewController
    func makeChatRoomViewController() -> UIViewController

}

public struct ChatFactoryImp: ChatFactory {
    public init() { }
    
    public func makeMainChatViewController(coordinator: MainChatViewControllerCoordinator) -> UIViewController {
        let controller = MainChatViewController(coordinator: coordinator)
        return controller
    }
    
    public func makeChatRoomViewController() -> UIViewController {
        let controller = ChatRoomViewController()
        return controller
    }
}
