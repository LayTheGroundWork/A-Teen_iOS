//
//  Injected.swift
//  Core
//
//  Created by 최동호 on 7/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Injected<T> {
    private var type: T.Type
    
    public var wrappedValue: T {
        AppContainer.resolve(type: type)
    }
    
    public init(_ type: T.Type) {
        self.type = type
    }
}
