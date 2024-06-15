//
//  CustomServiceButton.swift
//  ATeen
//
//  Created by 노주영 on 5/28/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

final class CustomServiceButton: CustomImageLabelButton {
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
extension CustomServiceButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
        
        customImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(self.customLabel.snp.trailing).offset(5)
            make.width.height.equalTo(ViewValues.defaultButtonSize)
        }
    }
}




