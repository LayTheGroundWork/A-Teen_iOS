//
//  ProfileDetailFactory.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

import Common
import FeatureDependency
import UIKit

public protocol ProfileDetailFactory {
    func makeProfileDetailViewController(coordinator: ProfileDetailViewControllerCoordinator) -> UIViewController
    func makeSNSBottomSheetCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        contentViewController: UIViewController,
        delegate: SNSBottomSheetCoordinatorDelegate
    ) -> Coordinator
}

public struct ProfileDetailFactoryImp: ProfileDetailFactory {
    private(set) var frame: CGRect
    private(set) var todayTeen: TodayTeen
    
    public init(frame: CGRect, todayTeen: TodayTeen) {
        self.frame = frame
        self.todayTeen = todayTeen
    }
    
    public func makeProfileDetailViewController(coordinator: ProfileDetailViewControllerCoordinator) -> UIViewController {
        let viewModel = ProfileDetailViewModel()
        let controller = ProfileDetailViewController(
            viewModel: viewModel,
            coordinator: coordinator,
            frame: frame,
            todayTeen: todayTeen)
        
        controller.modalPresentationStyle = .overFullScreen
        
        return controller
    }
    
    public func makeSNSBottomSheetCoordinator(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        contentViewController: UIViewController,
        delegate: SNSBottomSheetCoordinatorDelegate
    ) -> Coordinator {
        let factory = SNSBottomSheetFactoryImp()
        return SNSBottomSheetCoordinator(
            navigation: navigation,
            factory: factory,
            childCoordinators: childCoordinators,
            contentViewController: contentViewController,
            delegate: delegate)
    }
}
