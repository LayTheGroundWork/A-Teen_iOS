//
//  LoginBirthViewModel.swift
//  HiProject
//
//  Created by 노주영 on 5/29/24.
//

import UIKit

public class LoginBirthViewModel {
    //UserBirth
    public var year: String = ""
    public var month: String = ""
    public var day: String = ""
    
    //SearchSchool
    public var filteredSchools: [String] = []
    public var schools = ["seoul","seoul2", "busan", "busan2", "changwon", "anyang", "busan3", "busan4", "busan5", "busan6", "busan7", "busan8", "busan9", "busan10", "busan11","busan12"]
    public var selectIndexPath: IndexPath?
    
}

// MARK: - UserBirth
extension LoginBirthViewModel {
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
extension LoginBirthViewModel {
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
