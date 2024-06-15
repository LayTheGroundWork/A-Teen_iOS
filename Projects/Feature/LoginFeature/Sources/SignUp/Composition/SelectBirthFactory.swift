//
//  SelectBirthFactory.swift
//  ATeen
//
//  Created by 노주영 on 5/30/24.
//

import UIKit

public protocol SelectBirthFactory {
    func makeSelectBirthViewController(coordinator: SelectBirthCoordinator) -> UIViewController
}

public struct SelectBirthFactoryImp: SelectBirthFactory {
    private(set) var viewModel: LoginBirthViewModel
    private(set) var beforeYear: String
    private(set) var beforeMonth: String
    private(set) var beforeDay: String
    
    public init(viewModel: LoginBirthViewModel, beforeYear: String, beforeMonth: String, beforeDay: String) {
        self.viewModel = viewModel
        self.beforeYear = beforeYear
        self.beforeMonth = beforeMonth
        self.beforeDay = beforeDay
    }
    
    public func makeSelectBirthViewController(coordinator: SelectBirthCoordinator) -> UIViewController {
        let controller = SelectBirthViewController(
            coordinator: coordinator,
            viewModel: viewModel,
            beforeYear: beforeYear,
            beforeMonth: beforeMonth,
            beforeDay: beforeDay)
        return controller
    }
}
