//
//  SelectBirthFactory.swift
//  ATeen
//
//  Created by 노주영 on 5/30/24.
//

import UIKit

protocol SelectBirthFactory {
    func makeSelectBirthViewController(coordinator: SelectBirthCoordinator) -> UIViewController
}

struct SelectBirthFactoryImp: SelectBirthFactory {
    private(set) var viewModel: LoginBirthViewModel
    private(set) var beforeYear: String
    private(set) var beforeMonth: String
    private(set) var beforeDay: String
    
    func makeSelectBirthViewController(coordinator: SelectBirthCoordinator) -> UIViewController {
        let controller = SelectBirthViewController(
            coordinator: coordinator,
            viewModel: viewModel,
            beforeYear: beforeYear,
            beforeMonth: beforeMonth,
            beforeDay: beforeDay)
        return controller
    }
}
