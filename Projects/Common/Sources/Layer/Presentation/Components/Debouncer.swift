//
//  Debouncer.swift
//  Common
//
//  Created by 최동호 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public class Debouncer {
    private var timer: Timer?
    private let interval: TimeInterval
    private var action: (() -> Void)?
    
    public init(interval: TimeInterval) {
        self.interval = interval
    }
    
    public func call(action: @escaping () -> Void) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
            self?.action = action
            self?.action?()
        }
    }
    
    public func cancel() {
        timer?.invalidate()
        timer = nil
    }
}
