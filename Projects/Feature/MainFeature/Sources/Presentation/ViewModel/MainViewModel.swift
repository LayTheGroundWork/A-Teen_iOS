//
//  MainViewModel.swift
//  ATeen
//
//  Created by 노주영 on 5/24/24.
//

import Core
import Common
import DesignSystem
import UIKit

class MainViewModel {
    var auth: Auth?
    
    var categoryList: [ProfileCategory] = [
        ProfileCategory(title: "전체", isSelect: true),
        ProfileCategory(title: "뷰티", isSelect: false),
        ProfileCategory(title: "운동", isSelect: false),
        ProfileCategory(title: "요리", isSelect: false),
        ProfileCategory(title: "춤", isSelect: false),
        ProfileCategory(title: "노래", isSelect: false)
    ]
    
    var todayTeenList: [TodayTeen] = [
        TodayTeen(name: "검은 애", image: DesignSystemAsset.blackGlass.image),
        TodayTeen(name: "드레스 입은 애", image: DesignSystemAsset.dressGlass.image),
        TodayTeen(name: "밤에 찍은 애", image: DesignSystemAsset.nightGlass.image),
        TodayTeen(name: "파란 애", image: DesignSystemAsset.skyGlass.image),
        TodayTeen(name: "하얀 애", image: DesignSystemAsset.whiteGlass.image),
    ]
    
    func getCategoryItemMainViewModel(row: Int) -> ProfileCategory {
        categoryList[row]
    }
    
    func getTodayTeenItemMainViewModel(row: Int) -> TodayTeen {
        todayTeenList[row]
    }
}

// MARK: - Section 1
extension MainViewModel {
    func didSelectCategoryCell(row: Int) {
        guard let beforeIndex = categoryList.firstIndex(where: { $0.isSelect == true }) else {
            return
        }
        
        if beforeIndex != row {
            categoryList[beforeIndex].isSelect = false
            categoryList[row].isSelect = true
        }
    }
    
    func didSelectTodayTeenHeartButton() {
        print("HeartButton")
    }
}
