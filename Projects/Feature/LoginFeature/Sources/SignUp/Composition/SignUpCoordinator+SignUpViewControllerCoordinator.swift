//
//  SignUpCoordinator+SignUpViewControllerCoordinator.swift
//  ATeen
//
//  Created by 노주영 on 5/30/24.
//

import Common
import FeatureDependency
import Foundation

extension SignUpCoordinator: SignUpViewControllerCoordinator {
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    public func didSelectBirth() {
        let selectBirthCoordinator = factory.makeSelectBirthCoordinator(
            delegate: self
        )
        
        addChildCoordinatorStart(selectBirthCoordinator)
        
        navigation.present(
            selectBirthCoordinator.navigation.rootViewController,
            animated: false)
    }
    
    public func didSelectService() {
        print("123421412")
    }
    
    func didSelectCell(item: Int) {
        let albumCoordinator = coordinatorProvider.makeAlbumCoordinator(
            delegate: self)
        addChildCoordinatorStart(albumCoordinator)
        navigation.present(
            albumCoordinator.navigation.rootViewController,
            animated: true)
        
        albumCoordinator.navigation.dismissNavigationFromAlbum = { [weak self] album in
            self?.didFinishAlbum(childCoordinator: albumCoordinator)
            self?.signUpViewControllerDelegate?.updateImage(index: item, selectItem: album)
        }
    }
}

