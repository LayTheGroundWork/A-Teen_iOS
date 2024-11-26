//
//  SettingsTableViewCell.swift
//  ProfileFeature
//
//  Created by 노주영 on 11/22/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

class SettingsTableViewCell: UITableViewCell {
    private var viewModel: SettingsViewModel?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .subheadline, weight: .bold)
        return label
    }()
    
    private lazy var subTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = DesignSystemAsset.mainColor.color
        label.textAlignment = .right
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.arrowRightSmallIcon.image
        return imageView
    }()
    
    private lazy var settingSwitch: UISwitch = {
        let settingSwitch = UISwitch()
        settingSwitch.onTintColor = DesignSystemAsset.mainColor.color
        settingSwitch.addTarget(self, action: #selector(onClickSwitch(_:)), for: .valueChanged)
        return settingSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.tintColor = UIColor.black
        titleLabel.text = ""
        subTextLabel.text = ""
        settingSwitch.isOn = false
    }
    
    func setProperties(
        viewModel: SettingsViewModel,
        indexPath: IndexPath
    ) {
        self.viewModel = viewModel
        
        configUserInterface(indexPath: indexPath)
        configLayout(indexPath: indexPath)
    }
    
    private func configUserInterface(indexPath: IndexPath) {
        guard let viewModel = self.viewModel else { return }
        
        contentView.addSubview(titleLabel)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                titleLabel.text = "알림 설정"
                settingSwitch.isOn = viewModel.userSettings.isNotificationSetting
                contentView.addSubview(settingSwitch)
            case 1:
                titleLabel.text = "대회 참여"
                settingSwitch.isOn = viewModel.userSettings.isTournamentJoin
                contentView.addSubview(settingSwitch)
            case 2:
                titleLabel.text = "동영상 자동 재생"
                subTextLabel.text = viewModel.changeTextFromVideoTypeNumber()
                contentView.addSubview(subTextLabel)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                titleLabel.text = "서비스 이용약관"
                contentView.addSubview(rightArrowImageView)
            case 1:
                titleLabel.text = "개인정보 처리방침"
                contentView.addSubview(rightArrowImageView)
            case 2:
                titleLabel.text = "문의하기"
                contentView.addSubview(rightArrowImageView)
            case 3:
                if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                    subTextLabel.text = appVersion
                }
                titleLabel.text = "앱 버전"
                contentView.addSubview(subTextLabel)
            case 4:
                titleLabel.text = "로그아웃"
            case 5:
                titleLabel.text = "회원 탈퇴"
            default:
                break
            }
        default:
            break
        }
    }
    
    private func configLayout(indexPath: IndexPath) {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.top.bottom.equalToSuperview().inset(15)
            make.trailing.equalTo(contentView.snp.centerX)
        }
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0, 1:
                settingSwitch.snp.makeConstraints { make in
                    make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                    make.centerY.equalTo(titleLabel.snp.centerY)
                }
            case 2:
                subTextLabel.snp.makeConstraints { make in
                    make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                    make.top.bottom.equalToSuperview().inset(15)
                    make.leading.equalTo(contentView.snp.centerX)
                }
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0, 1, 2:
                rightArrowImageView.snp.makeConstraints { make in
                    make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                    make.top.bottom.equalToSuperview().inset(15)
                    make.width.equalTo(24)
                }
            case 3:
                subTextLabel.snp.makeConstraints { make in
                    make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                    make.top.bottom.equalToSuperview().inset(15)
                    make.leading.equalTo(contentView.snp.centerX)
                }
            default:
                break
            }
        default:
            break
        }
    }
    
    // Action
    @objc private func onClickSwitch(_ sender: UISwitch) {
        guard let viewModel = self.viewModel else { return }
        switch titleLabel.text {
        case "알림 설정":
            viewModel.changeSettingValue(0)
        case "대회 참여":
            viewModel.changeSettingValue(1)
        default:
            break
        }
    }
}

extension SettingsTableViewCell: Reusable { }
