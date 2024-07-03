//
//  CropImageCoordinator.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency
import UIKit

public protocol CropImageCoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public final class CropImageCoordinator: Coordinator {
    public var navigation: Navigation
    public var childCoordinators: [Coordinator] = []
    var factory: CropImageFactory
    let selectImage: UIImage
    weak var delegate: CropImageCoordinatorDelegate?
    
    public init(
        navigation: Navigation,
        childCoordinators: [Coordinator],
        factory: CropImageFactory,
        selectImage: UIImage,
        delegate: CropImageCoordinatorDelegate
    ) {
        self.navigation = navigation
        self.childCoordinators = childCoordinators
        self.factory = factory
        self.selectImage = selectImage
        self.delegate = delegate
    }
    
    public func start() {
        let controller = factory.makeCropImageViewController(
            selectImage: selectImage,
            coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension CropImageCoordinator: ParentCoordinator { }
