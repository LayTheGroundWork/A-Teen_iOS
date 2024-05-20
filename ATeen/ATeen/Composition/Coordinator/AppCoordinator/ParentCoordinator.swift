//
//  ParentCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

protocol ParentCoordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
}

extension ParentCoordinator {
    func addChildCoordinatorStart(_ childCoordinator: Coordinator?) {
        guard let childCoordinator = childCoordinator else { return }
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
    
    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
    
    func clearAllChildsCoordinator() {
        childCoordinators = []
    }
}
