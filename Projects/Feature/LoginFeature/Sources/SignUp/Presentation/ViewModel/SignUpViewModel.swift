//
//  SignUpViewModel.swift
//  LoginFeature
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Common
import Domain
import Photos
import UIKit

public final class SignUpViewModel {
    @Injected(SignUseCase.self)
    public var useCase: SignUseCase
    
    // phoneNumber
    public var phoneNumber: String = .empty
    public var userId: String = .empty
    public var userName: String = .empty
    
    //UserBirth
    public var year: String = .empty
    public var month: String = .empty
    public var day: String = .empty
    
    public var schoolData: SchoolData = SchoolData(schoolName: .empty, schoolLocation: .empty)
    
    //SearchSchool
    public var filteredSchools: [String] = []
    public var schools = ["seoul", "seoul2", "busan", "busan2", "changwon", "anyang", "busan3", "busan4", "busan5", "busan6", "busan7", "busan8", "busan9", "busan10", "busan11","busan12"]
    public var selectIndexPath: IndexPath?
    
    var selectPhotoAsset = Array(repeating: AssetInfo.self, count: 10)
    
    private let authService = MyPhotoAuthService()
    
    func signUp() {
        /*
         useCase.signUp(request: <#T##SignUpRequest#>, completion: <#T##(Result<LogInResponse, Error>) -> Void#>)
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

// MARK: - SearchSchool
extension SignUpViewModel {
    public func filterSchools(text: String) {
        if text.isEmpty {
            filteredSchools = []
        } else {
            filteredSchools = schools.filter { school in
                school.contains(text)
            }
        }
    }
}
