//
//  SettingsUseCase.swift
//  Domain
//
//  Created by 최동호 on 12/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

public protocol SettingsUseCase {
    func logOut(request: LogOutRequest)
    func deleteAccount(request: DeleteAccountRequest)
    func getAuthToken() -> String?
}
