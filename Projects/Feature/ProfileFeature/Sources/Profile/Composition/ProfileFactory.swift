//
//  ProfileFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import Core
import FeatureDependency
import UIKit

public protocol ProfileFactory {
    func makeProfileViewController(coordinator: ProfileViewControllerCoordinator) -> UIViewController
    func makeSettingCoordinator(
        navigation: Navigation,
        parentCoordinator: ParentCoordinator,
        delegate: SettingsCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> Coordinator
    func makeLinksDialogCoordinator(
        delegate: LinksDialogCoordinatorDelegate
    ) -> Coordinator
    func makeIntroduceCoordinator(
        navigation: Navigation,
        parentCoordinator: ParentCoordinator,
        delegate: IntroduceCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> Coordinator
    func makeQuestionsCoordinator(
        navigation: Navigation,
        parentCoordinator: ParentCoordinator,
        delegate: QuestionsCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> Coordinator
}

public struct ProfileFactoryImp: ProfileFactory {
    let appContainer: AppContainer?
    let viewModel = ProfileViewModel()
    
    public init(appContainer: AppContainer?) {
        self.appContainer = appContainer
    }
    
    public func makeProfileViewController(
        coordinator: ProfileViewControllerCoordinator
    ) -> UIViewController {
        let controller = ProfileViewController(viewModel: viewModel, coordinator: coordinator)
        return controller
    }
    
    public func makeSettingCoordinator(
        navigation: Navigation,
        parentCoordinator: ParentCoordinator,
        delegate: SettingsCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> Coordinator {
        let factory = SettingsFactoryImp(appContainer: appContainer)
        let coordinator = SettingsCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            childCoordinators: childCoordinators)
        return coordinator
    }
    
    public func makeLinksDialogCoordinator(delegate: LinksDialogCoordinatorDelegate) -> Coordinator {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.view.backgroundColor = UIColor.clear
        let navigation = NavigationImp(rootViewController: navigationController)
        let factory = LinksDialogFactoryImp(viewModel: viewModel)

        let coordinator = LinksDialogCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate)
        return coordinator
    }
    
    public func makeIntroduceCoordinator(
        navigation: Navigation,
        parentCoordinator: ParentCoordinator,
        delegate: IntroduceCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> Coordinator {
        let factory = IntroduceFactoryImp(appContainer: appContainer)
        let coordinator = IntroduceCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            childCoordinators: childCoordinators)
        return coordinator
    }
    
    public func makeQuestionsCoordinator(
        navigation: Navigation,
        parentCoordinator: ParentCoordinator,
        delegate: QuestionsCoordinatorDelegate,
        childCoordinators: [Coordinator]
    ) -> Coordinator {
        let factory = QuestionsFactoryImp()
        let coordinator = QuestionsCoordinator(
            navigation: navigation,
            factory: factory,
            delegate: delegate,
            childCoordinators: childCoordinators)
        return coordinator
    }
    
}
