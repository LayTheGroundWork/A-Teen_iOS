//
//  LogInFactory.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

struct LogInFactory {
    let appContainer: AppContainer?
    
    func makeLoginViewController(coordinator: LogInViewControllerCoordinator) -> UIViewController {
        let viewModel = LogInViewModel(logInAuth: appContainer?.auth)
        return LogInViewController(
            coordinator: coordinator,
            viewModel: viewModel)
    }
}
