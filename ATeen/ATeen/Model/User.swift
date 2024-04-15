//
//  User.swift
//  ATeen
//
//  Created by 최동호 on 4/15/24.
//

import Foundation

struct User: Equatable, Identifiable {
    let id = UUID()
    
    var name: String
    var phoneNumber: String
    var birth: String
    var schoolName: String
    var age: Int
    var gender: String
}


