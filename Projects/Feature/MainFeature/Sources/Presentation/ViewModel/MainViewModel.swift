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
        ProfileCategory(title: "공부", isSelect: false),
        ProfileCategory(title: "예술", isSelect: false),
        ProfileCategory(title: "게임", isSelect: false),
        ProfileCategory(title: "기타", isSelect: false)
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
            likeStatus: true)
        ]
    
    
    var teenList: [UserData] = []
    
    var currentPage: Int = 0
    var currentSize: Int = 0
    var isLoading: Bool = false
}

extension MainViewModel {
    func clearTeenList() {
        teenList.removeAll()
        currentPage = 0
        currentSize = 0
    }
    
    func didSelectCategoryCell(row: Int) {
        guard let beforeIndex = categoryList.firstIndex(where: { $0.isSelect == true }),
              beforeIndex != row
        else {
            return
        }
        categoryList[beforeIndex].isSelect = false
        categoryList[row].isSelect = true
        clearTeenList()
    }
    
    func didSelectTodayTeenHeartButton(
        row: Int,
        completion: @escaping () -> Void
    ) {
        guard let token = auth.getAccessToken(),
              auth.isSessionActive      //앱 팅겨서 임시로 넣어놓음
        else {
            completion()
            return
        }
        
        switch teenList[row].likeStatus {
        case true:
            userUseCase.cancelUserLikeStatus(request: .init(authorization: token, id: teenList[row].id)) { data in
                if let _ = data {
                    self.teenList[row].likeStatus.toggle()
                    completion()
                }
            }
        case false:
            userUseCase.updateUserLikeStatus(request: .init(authorization: token, id: teenList[row].id)) { data in
                if let _ = data {
                    self.teenList[row].likeStatus.toggle()
                    completion()
                }
            }
        }
    }
    
    // 전체 유저 리스트
    func findAllUser(completion: @escaping () -> Void) {
        guard let token = auth.getAccessToken(),
              auth.isSessionActive      //로그인 상태 확인(토큰이 유효기한이 있어서 나중에 유효성 검사로 바꿀 예정)
        else {
            loadAllUserList(authorization: nil, completion: completion)
            return
        }
        loadAllUserList(authorization: token, completion: completion)
    }
    
    func loadAllUserList(
        authorization: String?,
        completion: @escaping () -> Void
    ) {
        userUseCase.findAllUser(
            request: .init(
                authorization: authorization,
                page: currentPage,
                size: 10)
        ) { teenList in
            self.teenList.append(contentsOf: teenList)
            self.currentPage += 1
            self.currentSize += 10
            completion()
        }
    }
    
    // 카테고리 별 유저 리스트
    func findCategoryUser(row: Int, completion: @escaping () -> Void) {
        guard let token = auth.getAccessToken(),
              auth.isSessionActive      //로그인 상태 확인(토큰이 유효기한이 있어서 나중에 유효성 검사로 바꿀 예정)
        else {
            loadCategoryUserList(
                authorization: nil,
                category: categoryList[row].title,
                completion: completion)
            return
        }
        loadCategoryUserList(
            authorization: token,
            category: categoryList[row].title,
            completion: completion)
    }
    
    func loadCategoryUserList(
        authorization: String?,
        category: String,
        completion: @escaping () -> Void
    ) {
        userUseCase.findCategoryUser(
            request: .init(
                authorization: authorization,
                category: category,
                page: currentPage,
                size: 10)
        ) { teenList in
            self.teenList.append(contentsOf: teenList)
            self.currentPage += 1
            self.currentSize += 10
            completion()
        }
    }
    
    // 무한 스크롤
    func loadMoreData(completion: @escaping () -> Void) {
        isLoading = true
        DispatchQueue.global().async {
            if let index = self.categoryList.firstIndex(where: { $0.isSelect }) {
                switch index {
                case 0:
                    self.findAllUser(completion: completion)
                case 1, 2, 3, 4, 5, 6:
                    self.findCategoryUser(row: index, completion: completion)
                default:
                    break
                }
            }
        }
    }
}
