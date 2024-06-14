//
//  PhoneNumberCoordinator+ExistingUserLoginDialogCoordinatorDelegate.swift
//  ATeen
//
//  Created by phang on 6/9/24.
//

import FeatureDependency

extension PhoneNumberCoordinator: ExistingUserLoginDialogCoordinatorDelegate {
    func navigateToMainViewController(childCoordinator: Coordinator) {
        // 다이얼로그 닫기
        closeDialog(childCoordinator: childCoordinator)
        // 인증 화면 -> 로그인 : 뒤로가기
        navigateToLoginViewController()
        // 로그인 시트 닫기
        closeLoginSheet()
    }
    
    private func closeDialog(childCoordinator: Coordinator) {
        // 다이얼로그 닫기
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
    }
    
    private func navigateToLoginViewController() {
        // 인증 화면 -> 로그인 : 뒤로가기
        delegate?.didFinish(childCoordinator: self)
    }
    
    private func closeLoginSheet() {
        delegate?.navigateToMainViewController()
    }
}
