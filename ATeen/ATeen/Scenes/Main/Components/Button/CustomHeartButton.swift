//
//  CustomHeartView.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import SnapKit

import UIKit

final class CustomHeartButton: CustomImageLabelButton {
    override init(
        imageName: String,
        selectedImageName: String? = nil,
        imageColor: UIColor?,
        selectedImageColor: UIColor? = nil,
        textColor: UIColor,
        labelText: String,
        buttonBackgroundColor: UIColor,
        labelFont: UIFont,
        frame: CGRect
    ) {
        super.init(
            imageName: imageName,
            selectedImageName: selectedImageName,
            imageColor: imageColor,
            selectedImageColor: selectedImageColor,
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
extension CustomHeartButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(26)
        }
        
        customLabel.snp.makeConstraints { make in
            make.top.equalTo(self.customImageView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(24)
        }
    }
}
