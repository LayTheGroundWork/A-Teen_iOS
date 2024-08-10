//
//  SNSBottomSheetFactory.swift
//  ProfileDetailFeature
//
//  Created by 최동호 on 8/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import FeatureDependency
import UIKit

public protocol SNSBottomSheetFactory {
    func makeSNSBottomSheetViewController(
        contentViewController: UIViewController
    ) -> UIViewController
}

public struct SNSBottomSheetFactoryImp: SNSBottomSheetFactory {
    public func makeSNSBottomSheetViewController(
        contentViewController: UIViewController
    ) -> UIViewController {
        let controller = SNSBottomSheetViewController()
        return controller
    }
}
