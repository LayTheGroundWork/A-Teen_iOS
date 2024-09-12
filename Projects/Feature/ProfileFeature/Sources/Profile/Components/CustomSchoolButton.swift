//
//  CustomSchoolButton.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/12/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

class CustomSchoolButton: UIButton {
    private lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .callout, weight: .regular)
        return label
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = DesignSystemAsset.gray01.color
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var rightIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.rightGrayIcon.image
        return imageView
    }()
    
    init(
        frame: CGRect,
        schoolName: String,
        age: Int
    ) {
        super.init(frame: frame)
        schoolLabel.text = schoolName
        ageLabel.text = "\(age)세"
        
        self.backgroundColor = DesignSystemAsset.gray03.color
        self.clipsToBounds = true
        self.layer.cornerRadius = ViewValues.defaultRadius
        
        self.addSubview(rightIconImageView)
        self.addSubview(schoolLabel)
        self.addSubview(ageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomSchoolButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        rightIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.height.equalTo(24)
        }
        
        schoolLabel.snp.makeConstraints { make in
            make.bottom.equalTo(rightIconImageView.snp.centerY).offset(-1)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(rightIconImageView.snp.leading).offset(-ViewValues.defaultPadding)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(rightIconImageView.snp.centerY).offset(1)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(rightIconImageView.snp.leading).offset(-ViewValues.defaultPadding)
        }
    }
}
