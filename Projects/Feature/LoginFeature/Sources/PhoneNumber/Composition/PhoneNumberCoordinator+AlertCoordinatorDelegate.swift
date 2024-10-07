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
        guard let factory = factory as? PhoneNumberFactoryImp else { return }
        switch factory.signType {
        case .signIn:
            switch selectIndex {
            case 0:
                closeDialog(childCoordinator: childCoordinator)
            case 1:
                closeDialog(childCoordinator: childCoordinator)
                // 회원가입 화면으로 이동
                let termsOfUseCoordinator = factory.makeTermsOfUseCoordinator(
                    phoneNumber: viewModel.phoneNumber,
                    navigation: navigation,
                    childCoordinators: childCoordinators,
                    delegate: self)
                addChildCoordinatorStart(termsOfUseCoordinator)
            default:
                break
            }
        case .signUp:
            switch selectIndex {
            case 0:
                closeDialog(childCoordinator: childCoordinator)
            case 1:
                guard let tokenData = viewModel.temporaryTokenData else {
                    closeDialog(childCoordinator: childCoordinator)
                    return
                }
                
                viewModel.setAuth(tokenData) {
                    viewModel.temporaryTokenData = nil
                    
                    // 다이얼로그 닫기
                    closeDialog(childCoordinator: childCoordinator)
                    // 인증 화면 -> 로그인 : 뒤로가기
                    navigateToLoginViewController()
                    // 로그인 시트 닫기
                    closeLoginSheet()
                }
            default:
                break
            }
        }
      
    }
    
    func closeDialog(childCoordinator: Coordinator) {
        // 다이얼로그 닫기
        childCoordinator.navigation.dismissNavigation = nil
        removeChildCoordinator(childCoordinator)
        navigation.dismiss(animated: false)
    }

    func navigateToLoginViewController() {
        // 인증 화면 -> 로그인 : 뒤로가기
        delegate?.didFinish(childCoordinator: self)
    }
    
    func closeLoginSheet() {
        delegate?.navigateToMainViewController()
    }
}
