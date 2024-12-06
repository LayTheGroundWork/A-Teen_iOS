//
//  SettingsUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 12/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public struct SettingsUseCaseImp: SettingsUseCase {
    private let settingsService: SettingsService
    
    public init(settingsService: SettingsService) {
        self.settingsService = settingsService
    }
    
    public func logOut(request: LogOutRequest) {
        Task {
            await settingsService.signOut(request: request)
        }
    }
    
    public func deleteAccount(request: DeleteAccountRequest) {
        Task {
            await settingsService.deleteAccount(request: request)
        }
    }
 
    public func getAuthToken() -> String? {
        settingsService.getAuthToken()
    }
}
