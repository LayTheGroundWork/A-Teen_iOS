//
//  CropImageCoordinator+CropImageViewControllerCoordinator.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit
 
extension CropImageCoordinator: CropImageViewControllerCoordinator {
    public func didSelectCheckButton(selectImage: UIImage) {
        print("hi")
    }
    
    public func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
}
