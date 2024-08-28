//
//  CustomProfileBadgeButton.swift
//  DesignSystem
//
//  Created by phang on 7/8/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import UIKit

public enum CustomProfileBadgeButtonType {
    case badge
    case tournament
}

public class CustomProfileBadgeButton: UIButton {
    private lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .bold)
        return label
    }()
    
    private lazy var rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.rightIcon.image
        imageView.tintColor = UIColor.white
        imageView.layer.cornerRadius = ViewValues.defaultRadius
        return imageView
    }()
    
    private lazy var buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.white
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public init(
        frame: CGRect,
        title: String,
        count: String,
        imageType: CustomProfileBadgeButtonType
    ) {
        super.init(frame: frame)
        self.backgroundColor = DesignSystemAsset.mainColor.color
        
        setInfomation(
            title: title,
            count: count,
            imageType: imageType)
        
        self.addSubview(rightArrowImageView)
        self.addSubview(customTitleLabel)
        self.addSubview(countLabel)
        self.addSubview(buttonImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setInfomation(
        title: String,
        count: String,
        imageType: CustomProfileBadgeButtonType
    ) {
        self.customTitleLabel.text = title
        self.countLabel.text = count
        switch imageType {
        case .badge:
            buttonImageView.image = DesignSystemAsset.badgeButtonImage.image
        case .tournament:
            buttonImageView.image = DesignSystemAsset.teenBadgeImage.image
        }
    }
}

// MARK: - Layout
extension CustomProfileBadgeButton {
    public override func layoutSubviews() {
        super.layoutSubviews()
        rightArrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.height.equalTo(24)
        }
        
        customTitleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(rightArrowImageView.snp.leading).offset(-ViewValues.defaultPadding)
            make.height.equalTo(ViewValues.defaultPadding)
        }
        
        countLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.top.equalTo(customTitleLabel.snp.bottom).offset(3)
            make.trailing.equalTo(rightArrowImageView.snp.leading).offset(-ViewValues.defaultPadding)
            make.height.equalTo(ViewValues.defaultPadding)
        }
        
        buttonImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(2)
            make.height.equalTo(38)
        }
    }
}
