//
//  ProfileDetailFactory.swift
//  ATeen
//
//  Created by 노주영 on 5/25/24.
//

import UIKit

protocol ProfileDetailFactory {
    func makeProfileDetailViewController(coordinator: ProfileDetailCoordinator) -> UIViewController
}

struct ProfileDetailFactoryImp: ProfileDetailFactory {
    private(set) var frame: CGRect
    private(set) var todayTeen: TodayTeen
    
    func makeProfileDetailViewController(coordinator: ProfileDetailCoordinator) -> UIViewController {
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
