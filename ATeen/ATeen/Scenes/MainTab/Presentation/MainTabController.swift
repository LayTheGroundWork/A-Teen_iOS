//
//  MainTabController.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

final class MainTabController: UITabBarController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
    }
}
