//
//  PostDetailCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/20/24.
//

import UIKit

final class PostDetailCoordinator: Coordinator {
    var navigation: Navigation
    private let factory: PostDetailFactory
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

extension PostDetailCoordinator: PostDetailViewControllerCoordinator {
    func didTapPhotoButton() {
        navigation.present(factory.makePhotosViewController(), animated: true)
    }
    
    func didTapMoreDetailButton() {
        navigation.present(factory.makeMoreDetailViewController(), animated: true)
    }
    
    func didTapSourceButton() {
        navigation.present(factory.makeSourceViewController(), animated: true)
    }
}
