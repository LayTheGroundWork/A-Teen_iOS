//
//  CustomShowDetailButton.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import Common
import DesignSystem
import UIKit

final class CustomShowDetailButton: CustomImageLabelButton {
    override init(
        imageName: String = "chevron.right",
        selectedImageName: String? = nil,
        imageColor: UIColor? = DesignSystemAsset.gray01.color,
        selectedImageColor: UIColor? = nil,
        textColor: UIColor = DesignSystemAsset.gray01.color,
        labelText: String,
        buttonBackgroundColor: UIColor = .clear,
        labelFont: UIFont = UIFont.customFont(forTextStyle: .footnote,
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

// MARK: - Custom Show Detail Button Layout
extension CustomShowDetailButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        customImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(customLabel.snp.trailing).offset(2)
            make.height.equalTo(13)
            make.width.equalTo(7)
        }
    }
}
