//
//  SettingsServiceImp.swift
//  Data
//
//  Created by 최동호 on 12/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Core
import Domain
import Foundation

public struct SettingsServiceImp: SettingsService {
    private let auth: Auth
    private let signOutRepository: SignOutRepository
    private let deleteAccountRepository: DeleteAccountRepository
    
    public init(
        auth: Auth,
        signOutRepository: SignOutRepository,
        deleteAccountRepository: DeleteAccountRepository
    ) {
        self.auth = auth
        self.signOutRepository = signOutRepository
        self.deleteAccountRepository = deleteAccountRepository
    }
        
    public func signOut(request: LogOutRequest) async {
        let response = await signOutRepository.signOut(request: request)
        
        switch response {
        case .success(_):
            auth.logOut()
        case .failure(_):
            print("로그아웃 실패")
        }
    }
    
    public func deleteAccount(request: DeleteAccountRequest) async {
        let response = await deleteAccountRepository.deleteAccount(request: request)
        
        switch response {
        case .success(_):
            auth.logOut()
        case .failure(_):
            print("회원탈퇴 실패")
        }
    }
    
    public func getAuthToken() -> String? {
        return auth.getAccessToken()
    }
}
