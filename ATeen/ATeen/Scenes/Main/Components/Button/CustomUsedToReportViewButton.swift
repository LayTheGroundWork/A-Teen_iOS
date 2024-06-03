//
//  CustomUsedToReportViewButton.swift
//  ATeen
//
//  Created by phang on 5/31/24.
//

import UIKit

// MARK: - Custom Used To ReportView Button
final class CustomUsedToReportViewButton: CustomImageLabelButton {
    override init(
        imageName: String,
        selectedImageName: String?,
        imageColor: UIColor?,
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

// MARK: - Custom Used To ReportView Button Layout
extension CustomUsedToReportViewButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        customImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(22)
        }
        
        customLabel.snp.makeConstraints { make in
            make.leading.equalTo(customImageView.snp.trailing).offset(8)
            make.centerY.equalTo(customImageView.snp.centerY)
        }
    }
}
