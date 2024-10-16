//
//  MainViewModel.swift
//  ATeen
//
//  Created by 노주영 on 5/24/24.
//

import Core
import Common
import DesignSystem
import Domain
import UIKit

class MainViewModel {
    @Injected(Auth.self)
    public var auth: Auth
    
    @Injected(UserUseCase.self)
    public var userUseCase: UserUseCase
    
    var categoryList: [ProfileCategory] = [
        ProfileCategory(title: "전체", isSelect: true),
        ProfileCategory(title: "뷰티", isSelect: false),
        ProfileCategory(title: "운동", isSelect: false),
        ProfileCategory(title: "요리", isSelect: false),
        ProfileCategory(title: "춤", isSelect: false),
        ProfileCategory(title: "노래", isSelect: false)
    ]
    
    var todayTeenList: [UserData] = [
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
            likeStatus: true),
        .init(
            id: 4,
            uniqueId: "tester1",
            profileImages: "thumbnail_testKey",
            nickName: "최도혁",
            location: "서울",
            schoolName: "에이틴고등학교",
            likeStatus: true),
        .init(
            id: 5,
            uniqueId: "tester1",
            profileImages: "thumbnail_testKey",
            nickName: "박상준",
            location: "서울",
            schoolName: "에이틴고등학교",
            likeStatus: true),
        .init(
            id: 6,
            uniqueId: "tester1",
            profileImages: "thumbnail_testKey",
            nickName: "김영훈",
            location: "서울",
            schoolName: "에이틴고등학교",
            likeStatus: true),
        .init(
            id: 7,
            uniqueId: "tester1",
            profileImages: "thumbnail_testKey",
            nickName: "허세라",
            location: "서울",
            schoolName: "에이틴고등학교",
            likeStatus: true),
        .init(
            id: 8,
            uniqueId: "tester1",
            profileImages: "thumbnail_testKey",
            nickName: "윤영선",
            location: "서울",
            schoolName: "에이틴고등학교",
            likeStatus: true),
        .init(
            id: 9,
            uniqueId: "tester1",
            profileImages: "thumbnail_testKey",
            nickName: "공보경",
            location: "서울",
            schoolName: "에이틴고등학교",
            likeStatus: true)
    ]
}

extension MainViewModel {
    func getCategoryItemMainViewModel(row: Int) -> ProfileCategory {
        categoryList[row]
    }
    
    func getTodayTeenItemMainViewModel(row: Int) -> UserData {
        todayTeenList[row]
    }
    
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
    
    func findAllUser(completion: @escaping () -> Void) {
        guard let token = auth.getAccessToken(),
              auth.isSessionActive
        else { 
            completion()
            return
        }
        
        userUseCase.findAllUser(request: .init(authorization: token)) { teenList in
            self.todayTeenList.removeAll()
            self.todayTeenList = teenList
            completion()
        }
    }
    
    func findCategoryUser() {
        
    }
}
