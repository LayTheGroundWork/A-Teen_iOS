//
//  SignUpViewModel.swift
//  LoginFeature
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import Combine
import Domain
import Photos
import UIKit

public final class SignUpViewModel {
    @Injected(SignUseCase.self)
    public var signUseCase: SignUseCase
    
    @Injected(SearchUseCase.self)
    public var searchUseCase: SearchUseCase
    
    var state = PassthroughSubject<StateController, Never>()

    // phoneNumber
    public var phoneNumber: String = .empty
    public var userId: String = .empty
    public var userName: String = .empty
    
    //UserBirth
    public var year: String = .empty
    public var month: String = .empty
    public var day: String = .empty
    
    //SearchSchool
    public var schoolData: SchoolData = SchoolData(schoolName: .empty, schoolLocation: .empty)
    
    //Category
    public var category: CategoryType = CategoryType.etc
    
    public var searchSchoolText: String = .empty
    public var filteredSchools: [SchoolData] = []
    public var selectIndexPath: IndexPath?
    
    var selectPhotoAsset = Array(repeating: AssetInfo.self, count: 10)
    
    private let authService = MyPhotoAuthService()
    
    let categoryExplain: [CategoryType] = [
        .beauty,
        .exercise,
        .study,
        .art,
        .game,
        .etc
    ]
    
    // MARK: - Helpers
    public func searchSchoolData() {
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
                print(self.filteredSchools)
                print(self.filteredSchools.count)
                self.state.send(.success)
            case .failure(let error):
                self.state.send(.fail(error: error.localizedDescription))
            }
        }
    }
    
    func signUp() {
        /*
         signUseCase.signUp(request: <#T##SignUpRequest#>, completion: <#T##(Result<LogInResponse, Error>) -> Void#>)
         */
    }
}

// MARK: - UserBirth
extension SignUpViewModel {
    public func changeMonthState() -> Int {
        if month == "2" && (day == "29" || day == "30" || day == "31") {
            if leapYear() {
                day = "29"
            } else {
                day = "28"
            }
        } else if month == "4" && self.day == "31" {
            day = "30"
        } else if month == "6" && self.day == "31" {
            day = "30"
        } else if month == "9" && self.day == "31" {
            day = "30"
        } else if month == "11" && self.day == "31" {
            day = "30"
        }
        return (Int(day) ?? 1) - 1
    }
    
    public func leapYear() -> Bool {
        let yearInt = Int(year) ?? 0
        
        if yearInt % 400 == 0 {
            return true
        } else if yearInt % 100 != 0 && yearInt % 4 == 0{
            return true
        } else {
            return false
        }
    }
}

// MARK: - SelectCategory {
extension SignUpViewModel {
    public func changeCategory(index: Int, completion: (Int) -> Void) {
        guard let clearIndex = categoryExplain.firstIndex(of: category) else { return }
        category = categoryExplain[index]
        completion(clearIndex)
    }
}
