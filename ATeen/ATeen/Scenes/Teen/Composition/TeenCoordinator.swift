//
//  TeenCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

final class TeenCoordinator: Coordinator {
    var navigation: Navigation
    private var factory: TeenFactory
    
    init(
        navigation: Navigation,
        factory: TeenFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let controller = factory.makeTeenViewController()
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}
