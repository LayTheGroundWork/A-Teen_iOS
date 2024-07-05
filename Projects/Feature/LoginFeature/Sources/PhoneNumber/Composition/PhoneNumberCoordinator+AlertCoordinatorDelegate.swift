//
//  PhoneNumberCoordinator+AlertCoordinatorDelegate.swift
//  ATeen
//
//  Created by phang on 6/9/24.
//

import Common
import FeatureDependency

extension PhoneNumberCoordinator: AlertCoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator, selectIndex: Int) {
        switch selectIndex {
        case 0:
            closeDialog(childCoordinator: childCoordinator)
            print("버튼 두개인 경우도 다음 화면 가는건가?")
            print("안 가는 거면 여기서 인증 완료 버튼일 때만 가도록 나누기")
            // 이후 화면 이동
            let coordinator = factory.makeTermsOfUseCoordinator(
                navigation: navigation,
                childCoordinators: childCoordinators,
                delegate: self)
            addChildCoordinatorStart(coordinator)
        case 1:
            // 다이얼로그 닫기
            closeDialog(childCoordinator: childCoordinator)
            // 인증 화면 -> 로그인 : 뒤로가기
            navigateToLoginViewController()
            // 로그인 시트 닫기
            closeLoginSheet()
        default:
            break
        }
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
