//
//  SearchUserCoordinator+SearchUserViewControllerCoordinator.swift
//  MainFeature
//
//  Created by 노주영 on 11/21/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import UIKit

extension SearchUserCoordinator: SearchUserViewControllerCoordinator {
    func didFinish() {
        delegate?.didFinishSearchUser(childCoordinator: self)
    }
    
    func configTabbarState(view: MainViewNames) {
        delegate?.configTabbarState(view: view)
    }
    
    func didSelectUser(frame: CGRect?, todayTeen: User, todayTeenFirstImage: UIImage) {
        let profileDetailCoordinator = coordinatorProvider.makeProfileDetailCoordinator(
            navigation: navigation,
            delegate: self,
            frame: frame,
            todayTeen: todayTeen,
            todayTeenFirstImage: todayTeenFirstImage)
        
        addChildCoordinatorStart(profileDetailCoordinator)
    }
}
