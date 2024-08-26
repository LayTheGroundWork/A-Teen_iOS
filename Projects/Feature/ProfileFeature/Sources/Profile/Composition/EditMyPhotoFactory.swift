//
//  EditMyPhotoFactory.swift
//  ProfileFeature
//
//  Created by 최동호 on 8/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

public protocol EditMyPhotoFactory {
    func makeEditMyPhotoViewController(coordinator: EditMyPhotoViewControllerCoordinator) -> UIViewController
}

public final class EditMyPhotoFactoryImp: EditMyPhotoFactory {
    public func makeEditMyPhotoViewController(coordinator: EditMyPhotoViewControllerCoordinator) -> UIViewController {
        let controller = EditMyPhotoViewController(coordinator: coordinator)
        
        return controller
    }
    
    
}
