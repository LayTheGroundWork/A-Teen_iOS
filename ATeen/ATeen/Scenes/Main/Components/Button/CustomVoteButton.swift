//
//  CustomVoteButton.swift
//  ATeen
//
//  Created by 최동호 on 5/25/24.
//

import SnapKit

import UIKit

final class CustomVoteButton: CustomImageLabelButton {
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
    
    override func configuration() {
        self.backgroundColor = self.buttonBackgroundColor
        layoutSubviews()
    }
}

// MARK: - Layout
extension CustomVoteButton {
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let stackView = UIStackView(arrangedSubviews: [customImageView, customLabel])
        stackView.axis = .horizontal
        stackView.spacing = 3
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
