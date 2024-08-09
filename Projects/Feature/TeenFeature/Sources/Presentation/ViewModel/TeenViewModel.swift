//
//  TeenViewModel.swift
//  TeenFeature
//
//  Created by 최동호 on 7/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import DesignSystem
import Foundation

public final class TeenViewModel {
    var imageNames = [
        DesignSystemAsset.teencard1.image,
        DesignSystemAsset.teencard2.image,
        DesignSystemAsset.teencard3.image,
        DesignSystemAsset.teencard4.image,
        DesignSystemAsset.teencard5.image,
        DesignSystemAsset.teencard6.image,
        DesignSystemAsset.teencard7.image,
        DesignSystemAsset.teencard8.image
    ]
    
    var labels = [
        "투표 수가 많은\nTEEN",
        "우승한\nTEEN",
        "주간 인기\nTEEN",
        "월간 참여\nTEEN",
        "최근 가입한\nTEEN",
        "같은 학교인\nTEEN",
        "내가 투표했던\nTEEN",
        "배지가 많은\nTEEN"
    ]
}
