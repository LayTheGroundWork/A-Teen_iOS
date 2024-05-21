//
//  PostDetailCoordinator+PostDetailViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

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
