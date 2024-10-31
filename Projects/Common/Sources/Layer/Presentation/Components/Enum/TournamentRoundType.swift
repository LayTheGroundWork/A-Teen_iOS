//
//  TournamentRoundType.swift
//  Common
//
//  Created by 노주영 on 10/31/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public enum TournamentRoundType: String, CaseIterable {
    case roundOf16 = "16강"
    case roundOf8 = "8강"
    case semifinals = "4강"
    case final = "결승전"
    case end = ""
    
    public var matches: Int {
        switch self {
        case .roundOf16:
            return 8
        case .roundOf8:
            return 4
        case .semifinals:
            return 2
        case .final:
            return 1
        case .end:
            return 0
        }
    }
    
    public var progress: Float {
        switch self {
        case .roundOf16:
            return 0.125
        case .roundOf8:
            return 0.25
        case .semifinals:
            return 0.5
        case .final:
            return 1
        case .end:
            return 0
        }
    }
}
