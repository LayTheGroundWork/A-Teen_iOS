//
//  ProfileDetailFactory.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

import Common
import Domain
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
    private(set) var todayTeen: UserData
    private(set) var todayTeenFirstImage: UIImage
    
    public init(
        frame: CGRect,
        todayTeen: UserData,
        todayTeenFirstImage: UIImage
    ) {
        self.frame = frame
        self.todayTeen = todayTeen
        self.todayTeenFirstImage = todayTeenFirstImage
    }
    
    public func makeProfileDetailViewController(coordinator: ProfileDetailViewControllerCoordinator) -> UIViewController {
        let viewModel = ProfileDetailViewModel(uniqueId: todayTeen.uniqueId, todayTeenImages: [todayTeenFirstImage])
        let controller = ProfileDetailViewController(
            viewModel: viewModel,
            coordinator: coordinator,
            frame: frame)
        
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
