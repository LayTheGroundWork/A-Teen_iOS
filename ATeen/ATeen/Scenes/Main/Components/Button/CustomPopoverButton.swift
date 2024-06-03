//
//  CustomPopoverButton.swift
//  ATeen
//
//  Created by phang on 6/2/24.
//

import UIKit

// MARK: - CustomPopoverButton
final class CustomPopoverButton: CustomImageLabelButton {
    override init(
        imageName: String,
        selectedImageName: String? = nil,
        imageColor: UIColor? = .main,
        selectedImageColor: UIColor? = nil,
        textColor: UIColor = .black,
        labelText: String,
        buttonBackgroundColor: UIColor = .clear,
        labelFont: UIFont = .customFont(forTextStyle: .footnote,
                                        weight: .regular),
        frame: CGRect = .zero
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
extension CustomPopoverButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(23)
            make.width.height.equalTo(24)
        }
        
        customLabel.snp.makeConstraints { make in
            make.leading.equalTo(customImageView.snp.trailing).offset(9)
            make.centerY.equalTo(customImageView.snp.centerY)
        }
    }
}
