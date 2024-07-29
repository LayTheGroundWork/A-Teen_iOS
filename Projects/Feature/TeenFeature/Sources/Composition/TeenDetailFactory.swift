//
//  TeenDetailFactory.swift
//  TeenFeature
//
//  Created by 최동호 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

public protocol TeenDetailFactory {
    func makeTeenDetailViewController(
        coordinator: TeenDetailViewControllerCoordinator,
        labelText: String
    ) -> UIViewController
}

public struct TeenDetailFactoryImp: TeenDetailFactory {
    let viewModel = TeenDetailViewModel()
    
    public init() { }
    
    public func makeTeenDetailViewController(
        coordinator: TeenDetailViewControllerCoordinator,
        labelText: String
    ) -> UIViewController {
        let controller = TeenDetailViewController(
            viewModel: viewModel,
            coordinator: coordinator,
            selectedLabelText: labelText)
        return controller
    }
}
