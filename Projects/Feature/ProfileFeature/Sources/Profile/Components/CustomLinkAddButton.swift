//
//  CustomLinkAddButton.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

class CustomLinkAddButton: UIButton {
    lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.plusGray01Icon.image
        imageView.tintColor = UIColor.white
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = DesignSystemAsset.gray03.color.cgColor
        return imageView
    }()
    
    lazy var customtextLabel: UILabel = {
        let label = UILabel()
        label.text = "외부 링크 추가"
        label.textAlignment = .left
        label.textColor = DesignSystemAsset.gray02.color
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(plusImageView)
        self.addSubview(customtextLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomLinkAddButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        plusImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(40)
        }
        
        customtextLabel.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(plusImageView.snp.trailing).offset(10)
        }
    }
}
