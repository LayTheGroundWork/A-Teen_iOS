//
//  CustomNaviView.swift
//  ProfileFeature
//
//  Created by phang on 7/8/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import DesignSystem
import UIKit

class CustomNaviView: UIView {
    private weak var delegate: ProfileViewControllerCoordinator?
    
    private lazy var titleView: UILabel = {
        let label = UILabel()
        label.text = "내 프로필"
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var alarmButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.bellIcon.image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var settingButton: UIButton = {
        let button = UIButton()
        // TODO: - 디자인에 설정 아이콘 나오면 Asset 추가 후, 수정 예정
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    init(
        frame: CGRect,
        delegate: ProfileViewControllerCoordinator
    ) {
        self.delegate = delegate
        
        super.init(frame: frame)
        
        configUserInterface()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.backgroundColor = UIColor.clear
        
        self.addSubview(titleView)
        self.addSubview(alarmButton)
        self.addSubview(settingButton)
    }
    
    private func setupActions() {
        alarmButton.addTarget(
            self,
            action: #selector(clickAlarmButton(_:)),
            for: .touchUpInside)
        settingButton.addTarget(
            self,
            action: #selector(clickSettingButton(_:)),
            for: .touchUpInside)
    }
}

// MARK: - Layout
extension CustomNaviView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.settingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        self.alarmButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.settingButton.snp.leading).offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
}

// MARK: - Action
extension CustomNaviView {
    @objc func clickAlarmButton(_ sender: UIButton) {
        print("알림 버튼 클릭")
    }
    
    @objc func clickSettingButton(_ sender: UIButton) {
        print("세팅 버튼 클릭")
        // NotUsedSettings 그룹에 있는 화면들로 임시 이동
        delegate?.didTabSettingButton()
    }
}
