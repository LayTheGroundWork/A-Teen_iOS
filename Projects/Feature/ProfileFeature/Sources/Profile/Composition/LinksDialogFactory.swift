//
//  LinksDialogFactory.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

public protocol LinksDialogFactory {
    func makeLinksDialogViewController(
        coordinator: LinksDialogViewControllerCoordinator
    ) -> UIViewController
}

public struct LinksDialogFactoryImp: LinksDialogFactory {
    let viewModel: ProfileViewModel
    
    public init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    public func makeLinksDialogViewController(
        coordinator: LinksDialogViewControllerCoordinator
    ) -> UIViewController {
        let controller = LinksDialogViewController(
            viewModel: viewModel,
            coordinator: coordinator)
        return controller
    }
}
