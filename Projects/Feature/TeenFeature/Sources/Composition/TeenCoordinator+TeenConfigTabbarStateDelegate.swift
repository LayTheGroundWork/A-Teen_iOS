//
//  TeenCoordinator+TeenConfigTabbarStateDelegate.swift
//  TeenFeature
//
//  Created by 최동호 on 7/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import FeatureDependency

extension TeenCoordinator: TeenConfigTabbarStateDelegate {
    public func configTabbarState(view: TeenFeatureViewNames) {
        delegate?.configTabbarState(view: view)
    }
}
