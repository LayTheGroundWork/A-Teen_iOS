//
//  CustomTabBarButton.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import SnapKit

import UIKit

final class CustomTabBarButton: CustomImageLabelButton {
    override init(
        imageName: String,
        imageColor: UIColor?,
        textColor: UIColor,
        labelText: String,
        buttonBackgroundColor: UIColor,
        labelFont: UIFont,
        frame: CGRect
    ) {
        super.init(
            imageName: imageName,
            imageColor: imageColor,
            textColor: textColor,
            labelText: labelText,
            buttonBackgroundColor: buttonBackgroundColor,
            labelFont: labelFont,
            frame: frame
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomTabBarButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-22)
        }
        
        customImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.customLabel.snp.top).offset(-2)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
    }
}
