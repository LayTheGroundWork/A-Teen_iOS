//
//  LogInDTO.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 6/28/24.
//

import Foundation

struct LogInDTO: Decodable {
    let phoneNumber: String
    let userId: String
    let userName: String
    let birthDate: String
    let schoolName: String
}
