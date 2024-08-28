//
//  MainTabCoordinator+MainCoordinatorDelegate.swift
//  ATeen
//
//  Created by 노주영 on 5/27/24.
//

import Common
import MainFeature
import UIKit

extension MainTabCoordinator: MainCoordinatorDelegate {
    public func didSelectChattingButton() {
        let loginCoordinator = factory.makeLoginCoordinator(delegate: self)
        
        addChildCoordinatorStart(loginCoordinator)
        
        navigation.present(
            loginCoordinator.navigation.rootViewController,
            animated: true)
        
        loginCoordinator.navigation.dismissNavigation = { [weak self] in
            print("HIHI")
            NotificationCenter.default.post(
                name: .completeLogin,
                object: nil,
                userInfo: nil
            )
            self?.didFinishLogin(childCoordinator: loginCoordinator)
        }
    }
    
    public func didSelectAboutATeenCell(tag: TabTag) {
        guard let tab = navigation.viewControllers.first as? MainTabController else { return }
        
        switch tag {
        case .mainTab:
            tab.clickButton(tab.mainButton)
        case .rankingTab:
            tab.clickButton(tab.rankingButton)
        case .teenTab:
            tab.clickButton(tab.teenButton)
        case .chatTab:
            tab.clickButton(tab.chatButton)
        case .profileTab:
            tab.clickButton(tab.profileButton)
        }
    }
}
