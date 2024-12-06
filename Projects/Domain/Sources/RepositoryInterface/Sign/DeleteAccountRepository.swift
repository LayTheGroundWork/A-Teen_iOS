//
//  DeleteAccountRepository.swift
//  Domain
//
//  Created by 최동호 on 12/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol DeleteAccountRepository {
    func deleteAccount(request: DeleteAccountRequest) async -> Result<DefaultResponse, Error>
}
