//
//  DuplictaionCheckRepository.swift
//  Domain
//
//  Created by 최동호 on 9/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol DuplictaionCheckRepository {
    func duplicationCheck(request: DuplicationCheckRequest) async -> Result<DuplicationCheckResponse, Error>
}
