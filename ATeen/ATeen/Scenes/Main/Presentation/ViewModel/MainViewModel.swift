//
//  MainViewModel.swift
//  ATeen
//
//  Created by 노주영 on 5/24/24.
//

import UIKit

class MainViewModel {
    var auth: Auth?
    
    var categoryList: [Category] = [
        Category(title: "전체", isSelect: true),
        Category(title: "뷰티", isSelect: false),
        Category(title: "운동", isSelect: false),
        Category(title: "요리", isSelect: false),
        Category(title: "춤", isSelect: false),
        Category(title: "노래", isSelect: false)
    ]
    
    var todayTeenList: [TodayTeen] = [
        TodayTeen(name: "검은 애", image: UIImage(named: "blackGlass")!),
        TodayTeen(name: "드레스 입은 애", image: UIImage(named: "dressGlass")!),
        TodayTeen(name: "밤에 찍은 애", image: UIImage(named: "nightGlass")!),
        TodayTeen(name: "파란 애", image: UIImage(named: "skyGlass")!),
        TodayTeen(name: "하얀 애", image: UIImage(named: "whiteGlass")!),
    ]
    
    func getCategoryItemMainViewModel(row: Int) -> Category {
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
    
    func didSelectTodayTeenMenuButton() {
        print("MenuButton")
    }
}
