//
//  ChatFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

protocol ChatFactory {
    func makeChatViewController() -> UIViewController
}

struct ChatFactoryImp: ChatFactory {
    func makeChatViewController() -> UIViewController {
        let controller = ChatViewContoller()
        controller.navigationItem.title = "Chat"
        return controller
    }
}
