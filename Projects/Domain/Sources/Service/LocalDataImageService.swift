//
//  LocalDataImageService.swift
//  Domain
//
//  Created by 최동호 on 7/1/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public protocol LocalDataImageService {
    func save(key: String, data: Data?)
    func get(key: String) -> Data?
}
