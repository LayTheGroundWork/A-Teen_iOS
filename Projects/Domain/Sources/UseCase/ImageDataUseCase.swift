//
//  ImageDataUseCase.swift
//  Domain
//
//  Created by 최동호 on 7/1/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol ImageDataUseCase {
    func getData(url: String?) async -> Data?
}
