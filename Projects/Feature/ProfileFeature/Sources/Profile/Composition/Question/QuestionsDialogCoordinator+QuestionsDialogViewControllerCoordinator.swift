//
//  QuestionsDialogCoordinator+QuestionsDialogViewControllerCoordinator.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

extension QuestionsDialogCoordinator: QuestionsDialogViewControllerCoordinator {
    public func didFinish(changeValue: Bool) {
        delegate?.didFinish(childCoordinator: self, changeValue: changeValue)
    }
}
