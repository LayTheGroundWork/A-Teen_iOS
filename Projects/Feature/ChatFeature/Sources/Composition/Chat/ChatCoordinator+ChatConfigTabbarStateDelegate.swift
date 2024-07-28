//
//  ChatCoordinator+ChatConfigTabbarStateDelegate.swift
//  ChatFeature
//
//  Created by 김명현 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension ChatCoordinator: ChatConfigTabbarStateDelegate {
    public func configTabbarState(view: ChatFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
