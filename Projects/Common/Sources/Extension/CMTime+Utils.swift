//
//  CMTime+Utils.swift
//  Common
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import AVKit

extension CMTime {
    public var displayString: String {
        let offset = TimeInterval(seconds)
        
        let numberOfNanosecondsFloat = (offset - TimeInterval(Int(offset))) * 1000.0
        let nanoseconds = Int(numberOfNanosecondsFloat)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        
        var formattedString = formatter.string(from: offset) ?? "00:00"
        formattedString += String(format: ".%02d",
                                  nanoseconds).prefix(3) // .을 포함 3개 -> 소수점 2자리까지
        return formattedString
    }
}
