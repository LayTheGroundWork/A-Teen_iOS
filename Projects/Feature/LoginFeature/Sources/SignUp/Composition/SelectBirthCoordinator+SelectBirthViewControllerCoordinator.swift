//
//  SelectBirthCoordinator+SelectBirthViewControllerCoordinator.swift
//  ATeen
//
//  Created by 노주영 on 5/30/24.
//

extension SelectBirthCoordinator: SelectBirthViewControllerCoordinator {
    func didFinsh(didSelectBirth: Bool) {
        delegate?.didFinish(childCoordinator: self, didSelectBirth: didSelectBirth)
    }
}
