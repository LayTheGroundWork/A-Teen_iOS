//
//  ParentCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

public protocol ParentCoordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
}

extension ParentCoordinator {
    public func addChildCoordinatorStart(_ childCoordinator: Coordinator?) {
        guard let childCoordinator = childCoordinator else { return }
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
    
    public func removeChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
    
    public func clearAllChildsCoordinator() {
        childCoordinators = []
    }
    
    public func clearAllViewControllers(_ childCoordinator: Coordinator) {
        childCoordinator.navigation.viewControllers.forEach { viewController in
            viewController.view.subviews.forEach { view in
                view.removeFromSuperview()
            }
            viewController.removeFromParent()
        }
    }
}
