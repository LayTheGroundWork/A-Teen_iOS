//
//  ProfileDetailCoordinator.swift
//  FeatureDependency
//
//  Created by 노주영 on 6/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

public protocol ProfileDetailCoordinator: Coordinator {
    func didFinishFlow()
}

public protocol ProfileDetailViewControllerCoordinator: AnyObject {
    func didTapSNSButton(
        contentViewController: UIViewController
    )
    func didFinishFlow()
}
