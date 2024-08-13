//
//  LinkItem.swift
//  ProfileDetailFeature
//
//  Created by 강치우 on 8/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

struct LinkItem {
    let link: String
    let title: String
}

extension LinkItem {
    static let linkData = [
        LinkItem(link: "https://example.com", title: "공보경"),
        LinkItem(link: "https://notion.com", title: "공보경_노션 링크"),
        LinkItem(link: "https://instagram.com", title: "공보경_인스타그램 링크")
    ]
}
