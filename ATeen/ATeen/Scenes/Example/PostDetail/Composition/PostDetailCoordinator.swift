//
//  PostDetailCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/20/24.
//

import UIKit

final class PostDetailCoordinator: Coordinator {
    var navigation: Navigation
    let factory: PostDetailFactory
    private weak var parentCoordinator: ParentCoordinator?
    
    init(
        navigation: Navigation,
        factory: PostDetailFactory,
        parentCoordinator: ParentCoordinator
    ) {
        self.navigation = navigation
        self.factory = factory
        self.parentCoordinator = parentCoordinator
    }
    func start() {
        let controller = PostDetailViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true) { [weak self] in
            guard let self = self else { return }
            self.parentCoordinator?.removeChildCoordinator(self)
        }
    }
}
