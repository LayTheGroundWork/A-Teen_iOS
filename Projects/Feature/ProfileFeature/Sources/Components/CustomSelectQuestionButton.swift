//
//  CustomSelectQuestionButton.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

class CustomSelectQuestionButton: UIButton {
    lazy var customTextLabel: UILabel = {
        let label = UILabel()
        label.text = "질문 선택하기"
        label.textAlignment = .left
        label.textColor = DesignSystemAsset.gray01.color
        label.font = .customFont(forTextStyle: .callout, weight: .bold)
        return label
    }()
    
    lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.plusGray01Icon.image
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = DesignSystemAsset.gray03.color
        self.layer.cornerRadius = 10
        
        self.addSubview(plusImageView)
        self.addSubview(customTextLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomSelectQuestionButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        plusImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        customTextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalTo(plusImageView.snp.leading).offset(-10)
        }
    }
}
