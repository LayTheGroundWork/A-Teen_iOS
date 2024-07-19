//
//  ChatFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

public protocol ChatFactory {
    func makeChatViewController() -> UIViewController
}

public struct ChatFactoryImp: ChatFactory {
    public init() { }
    public func makeChatViewController() -> UIViewController {
        let controller = MainChatViewController()
        controller.navigationItem.title = "Chat"
        return controller
    }
}
