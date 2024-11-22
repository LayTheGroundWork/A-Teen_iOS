//
//  EditSchoolViewModel.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/12/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import Combine
import Domain
import UIKit

public final class EditSchoolViewModel {
    @Injected(MyPageUseCase.self)
    public var myPageUseCase: MyPageUseCase
    
    var state = PassthroughSubject<Void, Never>()
    var loadState = PassthroughSubject<IndicatorStateController, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    var filteredSchools: [SchoolData] = []
    
    var user: MyPageData
    var originSchool: SchoolData
    var changeSchool: SchoolData
    var searchSchoolText: String
    
    public init(user: MyPageData) {
        self.user = user
        self.originSchool = .init(schoolName: user.schoolName, schoolLocation: user.location)
        self.changeSchool = originSchool
        self.searchSchoolText = originSchool.schoolName
    }
}

extension EditSchoolViewModel {
    func checkChangeSchoolData() -> Bool {
        if originSchool == changeSchool || changeSchool.schoolName.isEmpty {
            return false
        }
        return true
    }
    
    func searchSchoolData() {
        loadState.send(.loading)
        myPageUseCase.searchSchool(request: SchoolDataRequest(schoolName: searchSchoolText))
            .sink { [weak self] data in
                guard let self else { return }
                self.filteredSchools = data
                
                if !self.filteredSchools.isEmpty {
                    self.loadState.send(.success)
                }
            }
            .store(in: &cancellables)
    }
    
    func saveChangeValue() {
        guard let token = myPageUseCase.getAuthToken() else { return }
        
        myPageUseCase.editMyPage(
            request: .init(
                authorization: token,
                nickName: user.nickName,
                schoolData: changeSchool,
                snsPlatform: user.snsPlatform,
                mbti: user.mbti,
                introduction: user.introduction,
                questions: user.questions)
        )
        .sink { [weak self] data in
            guard let self, let _ = data else { return }
            self.user.schoolName = self.changeSchool.schoolName
            self.user.location = self.changeSchool.schoolLocation
            self.state.send()
        }
        .store(in: &cancellables)
    }
}
