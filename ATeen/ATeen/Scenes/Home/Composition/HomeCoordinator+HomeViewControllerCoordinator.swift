//
//  HomeCoordinator+HomeViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/22/24.
//

extension HomeCoordinator: HomeViewControllerCoordinator {
    func didSelectPost(id: Int) {
        let postDetailCoordinator = factory.makePostDetailCoordinator(
            navigation: navigation,
            id: id,
            parentCoordinator: self)
        addChildCoordinatorStart(postDetailCoordinator)
    }
}
