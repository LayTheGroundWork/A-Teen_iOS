//
//  LocalDataImageServiceImp.swift
//  Data
//
//  Created by 최동호 on 7/1/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Domain
import Foundation

public struct LocalDataImageServiceImp: LocalDataImageService {
    private var dataStorage = NSCache<NSString, NSData>()
    
    public init() { }
    
    public func save(key: String, data: Data?) {
        guard let data = data else { return }
        dataStorage.setObject(data as NSData, forKey: key as NSString)
    }
    
    public func get(key: String) -> Data? {
        dataStorage.object(forKey: key as NSString) as? Data
    }
}
