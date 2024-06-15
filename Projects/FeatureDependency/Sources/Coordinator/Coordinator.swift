//
//  Coordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

import UIKit

public protocol Coordinator: AnyObject {
    var navigation: Navigation { get set }
    func start()
}
