//
//  MainCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func didSelectChattingButton()
    func didSelectAboutATeenCell(tag: TabTag)
}

final class MainCoordinator: Coordinator {
    var navigation: Navigation
    let factory: MainFactory
    var childCoordinators: [Coordinator] = []
    weak var delegate: MainCoordinatorDelegate?
    
    init(
        navigation: Navigation,
        factory: MainFactory,
        delegate: MainCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeMainViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension MainCoordinator: ParentCoordinator { }
