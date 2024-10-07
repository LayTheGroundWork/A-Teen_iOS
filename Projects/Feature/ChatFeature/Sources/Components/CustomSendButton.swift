//
//  CustomSendButton.swift
//  ChatFeature
//
//  Created by 김명현 on 8/8/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import DesignSystem
import UIKit

final class CustomSendButton: UIButton {
    lazy var sendTextLabel: UILabel = {
        let label = UILabel()
        label.text = "보내기"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    lazy var sendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.sendIcon.image
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(sendImageView)
        self.addSubview(sendTextLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomSendButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        sendImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(-2)
            make.trailing.equalToSuperview().offset(-7)
            make.width.equalTo(24)
        }
        
        sendTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(-2)
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalTo(sendImageView.snp.leading)
        }
    }
}
