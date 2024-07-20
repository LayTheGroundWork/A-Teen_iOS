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
import UIKit

public final class TeenDetailViewModel {
    var teenList: [TodayTeen] = [
        TodayTeen(name: "검은 애", image: DesignSystemAsset.blackGlass.image),
        TodayTeen(name: "드레스 입은 애", image: DesignSystemAsset.dressGlass.image),
        TodayTeen(name: "밤에 찍은 애", image: DesignSystemAsset.nightGlass.image),
        TodayTeen(name: "파란 애", image: DesignSystemAsset.skyGlass.image),
        TodayTeen(name: "하얀 애", image: DesignSystemAsset.whiteGlass.image),
    ]
    
    func getTeenItemTeenViewModel(row: Int) -> TodayTeen {
        teenList[row]
    }
    
    func didSelectTeenHeartButton() {
        print("HeartButton")
    }
}
