//
//  CustomLoginButton.swift
//  ATeen
//
//  Created by phang on 5/31/24.
//

import Common
import DesignSystem
import FeatureDependency
import UIKit

// MARK: - Custom Login Button
final class CustomLoginButton: CustomImageLabelButton {
    public override init(
        imageName: String = "chevron.right",
        selectedImageName: String? = nil,
        imageColor: UIColor? = DesignSystemAsset.mainColor.color,
        selectedImageColor: UIColor? = nil,
        textColor: UIColor = DesignSystemAsset.mainColor.color,
        labelText: String = AppLocalized.loginButton,
        buttonBackgroundColor: UIColor = .clear,
        labelFont: UIFont = UIFont.customFont(forTextStyle: .callout,
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

// MARK: - Custom Login Button Layout
extension CustomLoginButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        customImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(customLabel.snp.trailing).offset(3)
        }
    }
}
