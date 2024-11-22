//
//  SettingsCoordinator+SettingsViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import FeatureDependency

extension SettingsCoordinator: SettingsViewControllerCoordinator {
    public func didTapBackButton() {
        delegate?.didFinishSettingsViewController(childCoordinator: self)
    }
    
    public func didTapLogOut() {
        delegate?.didTapLogOut(childCoordinator: self)
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
}

