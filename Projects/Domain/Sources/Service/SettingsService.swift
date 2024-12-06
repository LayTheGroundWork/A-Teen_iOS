//
//  SettingsService.swift
//  Domain
//
//  Created by 최동호 on 12/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol SettingsService {
    func signOut(request: LogOutRequest) async
    func deleteAccount(request: DeleteAccountRequest) async
    func getAuthToken() -> String?
}
