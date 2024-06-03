//
//  SearchSchoolResultViewModel.swift
//  ATeen
//
//  Created by 노주영 on 5/31/24.
//

import Foundation

class SearchSchoolResultViewModel {
    var schools = ["seoul","seoul2", "busan", "busan2", "changwon", "anyang", "busan3", "busan4", "busan5", "busan6", "busan7", "busan8", "busan9", "busan10", "busan11","busan12"]
    var filteredSchools: [String] = []
    var selectIndexPath: IndexPath?
    
    func filterSchools(text: String) {
        if text.isEmpty {
            filteredSchools = []
        } else {
            filteredSchools = schools.filter{ school in
                school.contains(text)
            }
//            filteredSchools = schools.filter { school in
//                guard school.count >= text.count else {
//                    return false
//                }
//                
//                for (index, char) in text.enumerated() {
//                    let schoolChar = school[school.index(school.startIndex, offsetBy: index)]
//                    if char != schoolChar {
//                        return false
//                    }
//                }
//                return true
//            }
        }
    }
}
