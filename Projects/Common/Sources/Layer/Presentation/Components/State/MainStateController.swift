//
//  MainStateController.swift
//  Common
//
//  Created by 노주영 on 10/25/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Foundation

public enum MainStateController {
    case viewDidLoad
    case changeHeartState
    case getUserDataSuccess
    case loadMoreSuccess
    case loadMoreLoading
    case loadMoreFail(error: String)
}
