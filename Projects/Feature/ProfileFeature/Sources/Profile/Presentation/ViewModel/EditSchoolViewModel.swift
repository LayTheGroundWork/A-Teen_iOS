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
    @Injected(Auth.self)
    public var auth: Auth
    
    @Injected(MyPageUseCase.self)
    public var myPageUseCase: MyPageUseCase
    
    @Injected(SearchUseCase.self)
    public var searchUseCase: SearchUseCase
    
    var state = PassthroughSubject<StateController, Never>()
    
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
    
    func searchSchoolData(completion: @escaping () -> Void) {
        state.send(.loading)
        searchUseCase.searchSchool(request: SchoolDataRequest(schoolName: searchSchoolText)) { result in
            switch result {
            case .success(let schoolDataResponses):
                self.filteredSchools = schoolDataResponses.map {
                    .init(
                        schoolName: $0.name,
                        schoolLocation: $0.address
                    )
                }
                self.state.send(.success)
                
                if !self.filteredSchools.isEmpty {
                    completion()
                }
                
            case .failure(let error):
                self.state.send(.fail(error: error.localizedDescription))
            }
        }
    }
    
    func saveChangeValue(completion: @escaping() -> Void) {
        guard let token = auth.getAccessToken() else { return }
        
        myPageUseCase.editMyPage(
            request: .init(
                authorization: token,
                nickName: user.nickName,
                schoolData: changeSchool,
                snsPlatform: user.snsPlatform,
                mbti: user.mbti,
                introduction: user.introduction,
                questions: user.questions)
        ) { data in
            if let _ = data {
                self.user.schoolName = self.changeSchool.schoolName
                self.user.location = self.changeSchool.schoolLocation
                completion()
            }
        }
    }
}
