//
//  MyBadgeViewModel.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common

public class MyBadgeViewModel {
    var badgeList: [BadgeType]
    
    public init(badgeList: [BadgeType]) {
        self.badgeList = badgeList
    }
}