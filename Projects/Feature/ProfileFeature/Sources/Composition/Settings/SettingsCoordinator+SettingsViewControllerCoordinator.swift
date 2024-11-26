//
//  SettingsCoordinator+SettingsViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import Common
import DesignSystem
import FeatureDependency

extension SettingsCoordinator: SettingsViewControllerCoordinator {
    public func didTapBackButton() {
        delegate?.didFinishSettingsViewController(childCoordinator: self)
    }
    
    public func didTapVideoPlayType() {
        print("동영상 자동 재생 액션 시트")
    }
    
    public func didTapService() {
        print("서비스 이용약관 노션")
    }
    
    public func didTapInformation() {
        print("개인정보 처리방침 노션")
    }
    
    public func didTapInquire() {
        print("문의 하기 화면")
    }
    
    public func didTapVersion() {
        print("앱 스토어나 버전 화면")
    }
    
    public func didTapLogOut() {
        let coordinator = coordinatorProvider.makeAlertCoordinator(
            dialogType: .twoButton,
            delegate: self,
            dialogData: .init(
                dialogImage: nil,
                dialogTitle: "로그아웃 하시겠습니까?",
                titleColor: .black,
                titleNumberOfLine: 1,
                titleFont: .customFont(forTextStyle: .callout, weight: .bold),
                dialogMessage: nil,
                messageColor: nil,
                messageNumberOfLine: nil,
                messageFont: .customFont(forTextStyle: .footnote, weight: .regular),
                buttonText: "다음에",
                buttonColor: DesignSystemAsset.gray01.color,
                secondButtonText: "확인",
                secondButtonColor: .red))
        
        addChildCoordinatorStart(coordinator)
        
        navigation.present(
            coordinator.navigation.rootViewController,
            animated: false)
    }
    
    public func didTapDeleteUser() {
        let coordinator = coordinatorProvider.makeAlertCoordinator(
            dialogType: .twoButton,
            delegate: self,
            dialogData: .init(
                dialogImage: nil,
                dialogTitle: "탈퇴하시면 90일 간 가입이 불가능해요!",
                titleColor: .black,
                titleNumberOfLine: 1,
                titleFont: .customFont(forTextStyle: .callout, weight: .bold),
                dialogMessage: "탈퇴한 계정 아이디는 복구가 불가능합니다.\n그래도 탈퇴하시겠습니까?",
                messageColor: DesignSystemAsset.gray02.color,
                messageNumberOfLine: 2,
                messageFont: .customFont(forTextStyle: .footnote, weight: .regular),
                buttonText: "다음에",
                buttonColor: DesignSystemAsset.gray01.color,
                secondButtonText: "확인",
                secondButtonColor: .red))
        
        addChildCoordinatorStart(coordinator)
        
        navigation.present(
            coordinator.navigation.rootViewController,
            animated: false)
    }
}

