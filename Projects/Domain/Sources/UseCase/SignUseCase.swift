//
//  SignUseCase.swift
//  Domain
//
//  Created by 최동호 on 6/28/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol SignUseCase {
    func signIn()
    func signUp()
    func requestCode()
    func verificateCode()
}
