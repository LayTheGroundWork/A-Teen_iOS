//
//  CustomMbtiButton.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

class CustomMbtiButton: UIButton {
    lazy var customAlphabetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = DesignSystemAsset.mainColor.color
        label.font = .customFont(forTextStyle: .callout, weight: .bold)
        return label
    }()
    
    lazy var customtextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = DesignSystemAsset.mainColor.color
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    init(
        frame: CGRect,
        alphabet: String,
        text: String,
        tag: Int
    ) {
        super.init(frame: frame)
        customAlphabetLabel.text = alphabet
        customtextLabel.text = text
        
        self.tag = tag
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 2
        self.layer.borderColor = DesignSystemAsset.gray03.color.cgColor
        
        self.addSubview(customAlphabetLabel)
        self.addSubview(customtextLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomMbtiButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        customAlphabetLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY).offset(-1)
        }
        
        customtextLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.snp.centerY).offset(1)
        }
    }
}

