//
//  ChatViewModel.swift
//  ChatFeature
//
//  Created by 김명현 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import DesignSystem
import UIKit

public final class ChatViewModel {
    public var chatRooms: [ChatModel] = [
        ChatModel(profileImageName: DesignSystemAsset.dressGlass.image, name: "강치우", lastMessage: "안녕하세요! 반갑습니다 :)\n강치우라고 해요!", lastMessageTime: "5분전", unreadCount: 1),
        ChatModel(profileImageName: DesignSystemAsset.blackGlass.image, name: "김명현", lastMessage: "안녕하세요! 반갑습니다:)\n김명현이라고 해요!", lastMessageTime: "8분전", unreadCount: 2),
        ChatModel(profileImageName: DesignSystemAsset.nightGlass.image  , name: "노주영", lastMessage: "안녕하세요! 반갑습니다:)\n노주영이라고 해요!", lastMessageTime: "10분전", unreadCount: 5),
        ChatModel(profileImageName: DesignSystemAsset.skyGlass.image  , name: "이창준", lastMessage: "안녕하세요! 반갑습니다:)\n이창준이라고 해요!", lastMessageTime: "15분전", unreadCount: 3),
        ChatModel(profileImageName: DesignSystemAsset.whiteGlass.image  , name: "최동호", lastMessage: "안녕하세요! 반갑습니다:)\n최동호라고 해요!", lastMessageTime: "30분전", unreadCount: 10)]
    public var filteredChatRooms:[ChatModel] = []
}
