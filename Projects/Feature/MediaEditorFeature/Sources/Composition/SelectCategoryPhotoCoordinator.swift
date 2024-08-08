//
//  SelectCategoryPhotoCoordinator.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 8/8/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol SelectCategoryPhotoCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class SelectCategoryPhotoCoordinator: Coordinator {
    public var navigation: Navigation
    public var childCoordinators: [Coordinator] = []
    var factory: SelectCategoryPhotoFactory
    let selectImage: UIImage
    weak var delegate: SelectCategoryPhotoCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        factory: SelectCategoryPhotoFactory,
        selectImage: UIImage,
        delegate: SelectCategoryPhotoCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.childCoordinators = childCoordinators
        self.factory = factory
        self.selectImage = selectImage
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeSelectCategoryPhotoViewController(
            selectImage: selectImage,
            coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension SelectCategoryPhotoCoordinator: ParentCoordinator { }
