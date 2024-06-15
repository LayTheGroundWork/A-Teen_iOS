//
//  TeenCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import FeatureDependency
import UIKit

public final class TeenCoordinator: Coordinator {
    public var navigation: Navigation
    private var factory: TeenFactory
    
    public init(
        navigation: Navigation,
        factory: TeenFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    
    public func start() {
        let controller = factory.makeTeenViewController()
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}
