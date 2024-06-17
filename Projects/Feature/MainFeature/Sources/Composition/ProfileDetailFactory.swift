//
//  ProfileDetailFactory.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

import Common
import FeatureDependency
import UIKit

public struct ProfileDetailFactoryImp {
    private(set) var frame: CGRect
    private(set) var todayTeen: TodayTeen
    
    public init(frame: CGRect, todayTeen: TodayTeen) {
        self.frame = frame
        self.todayTeen = todayTeen
    }
    
    public func makeProfileDetailViewController(coordinator: ProfileDetailCoordinatorImp) -> UIViewController {
        let viewModel = ProfileDetailViewModel()
        let controller = ProfileDetailViewController(
            viewModel: viewModel,
            coordinator: coordinator,
            frame: frame,
            todayTeen: todayTeen)
        
        controller.modalPresentationStyle = .overFullScreen
        
        return controller
    }
}
