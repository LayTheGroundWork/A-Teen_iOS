//
//  Coordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigation: UINavigationController { get set }
    func start()
}
