//
//  SearchUserViewModel.swift
//  MainFeature
//
//  Created by 노주영 on 11/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import Foundation

class SearchUserViewModel {
    var searchUserList: [User] = []
    var searchUserText: String = ""
}

extension SearchUserViewModel {
    func clearListAndText() {
        searchUserList.removeAll()
        searchUserText = ""
    }
    
    func getSearchUserList() {
        // TODO: 검색 api 로직
        searchUserList.append(.init(
            id: 0,
            uniqueId: "tester2",
            profileImage: "thumbnail_testKey",
            nickName: "노주영",
            location: "안양",
            schoolName: "인덕원고둥학교",
            birthDay: "2025-01-03",
            likeStatus: false))
    }
}
