//
//  ProfileCoordinator+ProfileViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/24/24.
//

import FeatureDependency

extension ProfileCoordinator: ProfileViewControllerCoordinator {
    public func didTabSettingButton() {
        let coordinator = factory.makeSettingCoordinator(
            navigation: navigation,
            parentCoordinator: self,
            delegate: self,
            childCoordinators: childCoordinators)
        addChildCoordinatorStart(coordinator)
    }
    
    public func didTabEditMyPhotoButton() {
        let coordinator = factory.makeEditMyPhotoCoordinator(
            navigation: navigation,
            coordinatorProvider: coordinatorProvider,
            childCoordinators: childCoordinators,
            delegate: self)
        addChildCoordinatorStart(coordinator)
    }
    
    public func didTabEditUserNameButton() {
        let coordinator = factory.makeEditUserNameCoordinator(
            navigation: navigation,
            parentCoordinator: self,
            delegate: self,
            childCoordinators: childCoordinators)
        addChildCoordinatorStart(coordinator)
    }
    
    public func didTabSchoolButton() {
        let coordinator = factory.makeEditSchoolCoordinator(
            navigation: navigation,
            parentCoordinator: self,
            delegate: self,
            childCoordinators: childCoordinators)
        addChildCoordinatorStart(coordinator)
    }
    
    public func didTabBadgeButton() {
        let coordinator = factory.makeMyBadgeCoordinator(
            navigation: navigation,
            parentCoordinator: self,
            delegate: self,
            childCoordinators: childCoordinators)
        addChildCoordinatorStart(coordinator)
    }
    
    public func didTabLinkButton() {
        let coordinator = factory.makeLinksDialogCoordinator(delegate: self)
        addChildCoordinatorStart(coordinator)
        
        navigation.present(
            coordinator.navigation.rootViewController,
            animated: false)
    }
    
    public func didTabIntroduceButton() {
        let coordinator = factory.makeIntroduceCoordinator(
            navigation: navigation,
            parentCoordinator: self,
            delegate: self,
            childCoordinators: childCoordinators)
        addChildCoordinatorStart(coordinator)
    }
    
    public func didTabQuestionButton() {
        let coordinator = factory.makeQuestionsCoordinator(
            navigation: navigation,
            parentCoordinator: self,
            delegate: self,
            childCoordinators: childCoordinators)
        addChildCoordinatorStart(coordinator)
    }
    
    public func configTabbarState(view: ProfileFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
