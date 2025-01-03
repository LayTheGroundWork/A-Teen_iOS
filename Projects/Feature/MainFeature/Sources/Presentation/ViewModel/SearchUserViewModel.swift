//
//  SearchUserViewModel.swift
//  MainFeature
//
//  Created by 노주영 on 11/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Combine
import Common
import Domain
import Foundation

class SearchUserViewModel {
    @Injected(UserUseCase.self)
    public var userUseCase: UserUseCase
    
    var state = PassthroughSubject<IndicatorStateController, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    var searchUserList: [SearchUserData] = []
    var searchUserText: String = ""
}

extension SearchUserViewModel {
    func clearListAndText() {
        searchUserList.removeAll()
        searchUserText = ""
    }
    
    func getSearchUserList() {
        state.send(.loading)
        userUseCase.searchUserList(request: .init(searchWord: searchUserText))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                self.searchUserList = data
                state.send(.success)
            }
            .store(in: &cancellables)
    }
}
