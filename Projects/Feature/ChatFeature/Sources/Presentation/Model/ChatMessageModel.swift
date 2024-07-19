//
//  ChatMessageModel.swift
//  ChatFeature
//
//  Created by 김명현 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

enum MessageType {
    case user
    case partner
}

struct ChatMessageModel {
    let text: String
    let messageType: MessageType
    let time: String
    var isHiddenTimeLabel: Bool = false
}

