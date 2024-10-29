//
//  MainViewModel.swift
//  ATeen
//
//  Created by 노주영 on 5/24/24.
//

import Core
import Combine
import Common
import DesignSystem
import Domain
import UIKit

enum LoadType {
    case viewDidLoad, more, normal
}

class MainViewModel {
    @Injected(Auth.self)
    public var auth: Auth
    
    @Injected(UserUseCase.self)
    public var userUseCase: UserUseCase
    
    var mainState = PassthroughSubject<MainStateController, Never>()
    var loadState = PassthroughSubject<IndicatorStateController, Never>()
    private var cancellables = Set<AnyCancellable>()
    
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
    
    func didSelectTodayTeenHeartButton(row: Int) {
        guard let token = auth.getAccessToken(),
              auth.isSessionActive      //앱 팅겨서 임시로 넣어놓음
        else {
            return
        }
        
        switch teenList[row].likeStatus {
        case true:
            userUseCase.cancelUserLikeStatus(request: 
                    .init(
                        authorization: token,
                        id: teenList[row].id)
            )
            .sink { [weak self] data in
                guard let self = self, let _ = data else {
                    return
                }
                self.teenList[row].likeStatus.toggle()
                self.mainState.send(.changeHeartState)
            }
            .store(in: &cancellables)
            
        case false:
            userUseCase.updateUserLikeStatus(request:
                    .init(
                        authorization: token,
                        id: teenList[row].id)
            )
            .sink { [weak self] data in
                guard let self = self, let _ = data else {
                    return
                }
                self.teenList[row].likeStatus.toggle()
                self.mainState.send(.changeHeartState)
            }
            .store(in: &cancellables)
        }
    }
    
    // 전체 유저 리스트
    func findAllUser(_ type: LoadType) {
        guard let token = auth.getAccessToken(),
              auth.isSessionActive      //로그인 상태 확인(토큰이 유효기한이 있어서 나중에 유효성 검사로 바꿀 예정)
        else {
            loadAllUserList(type, authorization: nil)
            return
        }
        loadAllUserList(type, authorization: token)
    }
    
    func loadAllUserList(
        _ type: LoadType,
        authorization: String?
    ) {
        userUseCase.findAllUser(
            request: .init(
                authorization: authorization,
                page: currentPage,
                size: 10)
        )
        .receive(on: type == .more ? DispatchQueue.global() : DispatchQueue.main)
        .sink { [weak self] data in
            guard let self else { return }
            self.teenList.append(contentsOf: data)
            self.currentPage += 1
            self.currentSize += 10
            
            switch type {
            case .viewDidLoad:
                self.mainState.send(.viewDidLoad)
            case .normal:
                self.mainState.send(.getUserDataSuccess)
            case .more:
                sleep(2)
                self.loadState.send(.success)
            }
        }
        .store(in: &cancellables)
    }
    
    // 카테고리 별 유저 리스트
    func findCategoryUser(_ type: LoadType, row: Int) {
        guard let token = auth.getAccessToken(),
              auth.isSessionActive      //로그인 상태 확인(토큰이 유효기한이 있어서 나중에 유효성 검사로 바꿀 예정)
        else {
            loadCategoryUserList(
                type,
                authorization: nil,
                category: categoryList[row].title)
            return
        }
        loadCategoryUserList(
            type,
            authorization: token,
            category: categoryList[row].title)
    }
    
    func loadCategoryUserList(
        _ type: LoadType,
        authorization: String?,
        category: String
    ) {
        userUseCase.findCategoryUser(
            request: .init(
                authorization: authorization,
                category: category,
                page: currentPage,
                size: 10)
        )
        .receive(on: type == .more ? DispatchQueue.global() : DispatchQueue.main)
        .sink { [weak self] data in
            guard let self else { return }
            self.teenList.append(contentsOf: data)
            self.currentPage += 1
            self.currentSize += 10
            
            switch type {
            case .viewDidLoad:
                break
            case .normal:
                self.mainState.send(.getUserDataSuccess)
            case .more:
                sleep(2)
                self.loadState.send(.success)
            }
        }
        .store(in: &cancellables)
    }
    
    // 무한 스크롤
    func loadMoreData() {
        loadState.send(.loading)
        isLoading = true
        if let index = self.categoryList.firstIndex(where: { $0.isSelect }) {
            switch index {
            case 0:
                self.findAllUser(.more)
                
            case 1, 2, 3, 4, 5, 6:
                self.findCategoryUser(.more, row: index)
            default:
                break
            }
        }
    }
}
