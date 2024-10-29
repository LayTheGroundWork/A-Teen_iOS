//
//  TeenViewModel.swift
//  TeenFeature
//
//  Created by 최동호 on 7/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import DesignSystem
import Domain
import UIKit

public final class TeenDetailViewModel {
    var teenList: [UserData] = [
        .init(
            id: 0,
            uniqueId: "tester1",
            profileImages: "thumbnail_testKey",
            nickName: "노주영",
            location: "안양",
            schoolName: "인덕원고둥학교",
            likeStatus: false),
        .init(
            id: 1,
            uniqueId: "tester1",
            profileImages: "thumbnail_testKey",
            nickName: "최동호",
            location: "부산",
            schoolName: "대연고등학교",
            likeStatus: true),
        .init(
            id: 2,
            uniqueId: "tester1",
            profileImages: "thumbnail_testKey",
            nickName: "김명현",
            location: "부산",
            schoolName: "센텀고등학교",
            likeStatus: true),
        .init(
            id: 3,
            uniqueId: "tester1",
            profileImages: "thumbnail_testKey",
            nickName: "이창준",
            location: "서울",
            schoolName: "에이틴고등학교",
            likeStatus: true)
    ]
    
    func getTeenItemTeenViewModel(row: Int) -> UserData {
        teenList[row]
    }
    
    func didSelectTeenHeartButton() {
        print("HeartButton")
    }
}
