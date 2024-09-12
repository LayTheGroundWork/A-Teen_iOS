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
    @Injected(SignUseCase.self)
    public var signUseCase: SignUseCase
    
    @Injected(SearchUseCase.self)
    public var searchUseCase: SearchUseCase
    
    var state = PassthroughSubject<StateController, Never>()
    
    var filteredSchools: [SchoolData] = []
    
    var originSchool: SchoolData
    var changeSchool: SchoolData
    var searchSchoolText: String
    
    public init(originSchool: SchoolData) {
        self.originSchool = originSchool
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
}
