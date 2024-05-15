//
//  AppCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigation: UINavigationController
    
    var window: UIWindow?
    var factory: AppFactory?
    var auth: Auth?
    
    init(
        navigation: UINavigationController,
        window: UIWindow?,
        factory: AppFactory?,
        auth: Auth?
    ) {
        self.navigation = navigation
        self.window = window
        self.factory = factory
        self.auth = auth
    }
    
    func start() {
        <#code#>
    }

}
