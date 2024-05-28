//
//  CustomBirthButton.swift
//  ATeen
//
//  Created by 노주영 on 5/28/24.
//

import SnapKit

import UIKit

final class CustomBirthButton: CustomImageLabelButton {
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
extension CustomBirthButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(161)
        }
        
        customImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(self.customLabel.snp.trailing).offset(5)
            make.width.height.equalTo(ViewValues.defaultButtonSize)
        }
    }
}



