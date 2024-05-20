//
//  PostDetailCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/20/24.
//

import UIKit

final class PostDetailCoordinator: Coordinator {
    var navigation: UINavigationController
    private let factory: PostDetailFactory
    
    init(
        navigation: UINavigationController,
        factory: PostDetailFactory
    ) {
        self.navigation = navigation
        self.factory = factory
    }
    func start() {
        let controller = PostDetailViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
        
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
