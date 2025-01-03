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
    @Injected(UserUseCase.self)
    public var userUseCase: UserUseCase
    
    var state = PassthroughSubject<MainStateController, Never>()
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
    var todayTeenList: [User] = []
    var teenList: [User] = []
    var totalPage: Int?
    var pageArray: [Int] = []
    var randomPage: Int? = 0
    var isLoading: Bool = false
    
}

extension MainViewModel {
    func clearTeenList() {
        todayTeenList.removeAll()
        teenList.removeAll()
        totalPage = nil
        pageArray.removeAll()
        randomPage = 0
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
        findCategoryData(.normal, row: row)
    }
    
    func didSelectChattingButton() {
        guard let _ = userUseCase.getAuthToken() else {
            // 로그인 시트 올리기
            state.send(.openLoginSheet)
            return
        }
        
        state.send(.gotoChattingRoom)
    }
    
    func didSelectTodayTeenHeartButton(isTodayTeen: Bool, row: Int) {
        guard let token = userUseCase.getAuthToken() else {
            // 로그인 시트 올리기
            state.send(.openLoginSheet)
            return
        }
        
        let selectedTeen = isTodayTeen ? todayTeenList[row] : teenList[row]
        
        switch selectedTeen.likeStatus {
        case true:
            userUseCase.cancelUserLikeStatus(request:
                    .init(
                        authorization: token,
                        id: selectedTeen.id)
            )
            .sink { [weak self] data in
                guard let self = self, let _ = data else {
                    self?.state.send(.openLoginSheet)
                    return
                }
                self.toggleLikeStatus(isTodayTeen: isTodayTeen, row: row)
                self.state.send(.changeHeartState)
            }
            .store(in: &cancellables)
            
        case false:
            userUseCase.updateUserLikeStatus(request:
                    .init(
                        authorization: token,
                        id: selectedTeen.id)
            )
            .sink { [weak self] data in
                guard let self = self, let _ = data else {
                    self?.state.send(.openLoginSheet)
                    return
                }
                self.toggleLikeStatus(isTodayTeen: isTodayTeen, row: row)
                self.state.send(.changeHeartState)
            }
            .store(in: &cancellables)
        }
    }
    
    private func toggleLikeStatus(isTodayTeen: Bool, row: Int) {
        if isTodayTeen {
            todayTeenList[row].likeStatus.toggle()
            
            if let index = teenList.firstIndex(where: { $0.id == todayTeenList[row].id }) {
                teenList[index].likeStatus.toggle()
            }
        } else {
            teenList[row].likeStatus.toggle()
            
            if let index = todayTeenList.firstIndex(where: { $0.id == teenList[row].id }) {
                todayTeenList[index].likeStatus.toggle()
            }
        }
    }
    
    // 오늘의 틴 및 유저 리스트 동시 처리
    func findCategoryData(_ type: LoadType, row: Int) {
        guard let token = userUseCase.getAuthToken() else {
            loadCategoryData(
                type,
                authorization: nil,
                row: row)
            return
        }
        loadCategoryData(
            type,
            authorization: token,
            row: row)
    }
    
    private func loadCategoryData(
        _ type: LoadType,
        authorization: String?,
        row: Int
    ) {
        let todayTeenPublisher = userUseCase.findCategoryTodatTeen(
            request: .init(
                authorization: authorization,
                category: changeCategoryName(categoryList[row].title))
        )
        
        let userListPublisher = userUseCase.findCategoryUser(
            request: .init(
                authorization: authorization,
                category: changeCategoryName(categoryList[row].title),
                page: randomPage ?? 0,
                size: 10)
        )
        
        Publishers.Zip(todayTeenPublisher, userListPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] todayTeenData, userData in
                guard let self else { return }
                self.todayTeenList = todayTeenData
                self.processByType(
                    type,
                    data: userData,
                    row: row)
            }
            .store(in: &cancellables)
    }
    
    // 카테고리 별 유저 리스트
    func findCategoryUser(_ type: LoadType, row: Int) {
        guard let token = userUseCase.getAuthToken() else {
            loadCategoryUserList(
                type,
                authorization: nil,
                row: row)
            return
        }
        loadCategoryUserList(
            type,
            authorization: token,
            row: row)
    }
    
    private func loadCategoryUserList(
        _ type: LoadType,
        authorization: String?,
        row: Int
    ) {
        userUseCase.findCategoryUser(
            request: .init(
                authorization: authorization,
                category: changeCategoryName(categoryList[row].title),
                page: randomPage ?? 0,
                size: 10)
        )
        .receive(on: type == .more ? DispatchQueue.global() : DispatchQueue.main)
        .sink { [weak self] data in
            guard let self else { return }
            self.processByType(
                type,
                data: data,
                row: row)
        }
        .store(in: &cancellables)
    }
    
    // 무한 스크롤
    func loadMoreData() {
        state.send(.loadMoreLoading)
        isLoading = true
        
        if let index = self.categoryList.firstIndex(where: { $0.isSelect }) {
            self.findCategoryUser(.more, row: index)
        }
    }
    
    private func processByType(
        _ type: LoadType,
        data: UserData,
        row: Int
    ) {
        switch type {
        case .viewDidLoad:
            if let _ = self.totalPage {
                self.teenList.append(contentsOf: data.users)
                self.extractRandomElement()
                self.state.send(.viewDidLoad)
            } else {
                self.totalPage = data.totalPage
                self.makeRandomPages()
                self.findCategoryUser(.viewDidLoad, row: row)
            }
        case .normal:
            if let _ = self.totalPage {
                self.teenList.append(contentsOf: data.users)
                self.extractRandomElement()
                self.state.send(.getUserDataSuccess)
            } else {
                self.totalPage = data.totalPage
                self.makeRandomPages()
                self.findCategoryUser(.normal, row: row)
            }
        case .more:
            self.teenList.append(contentsOf: data.users)
            self.extractRandomElement()
            sleep(2)
            self.state.send(.loadMoreSuccess)
        }
    }
    
    private func makeRandomPages() {
        guard let totalPage = totalPage else { return }
        pageArray = Array(0..<totalPage)
        extractRandomElement()
    }
    
    private func extractRandomElement() {
        guard !pageArray.isEmpty else {
            randomPage = nil
            return
        }
        randomPage = pageArray.randomElement()!
        
        if let index = pageArray.firstIndex(of: randomPage ?? 0) {
            pageArray.remove(at: index)
        }
    }
    
    private func changeCategoryName(_ category: String) -> String {
        switch category {
        case "전체": return "ALL"
        case "뷰티": return "BEAUTY"
        case "운동": return "SPORT"
        case "공부": return "STUDY"
        case "예술": return "ART"
        case "게임": return "GAME"
        case "기타": return "ETC"
        default: return ""
        }
    }
}
