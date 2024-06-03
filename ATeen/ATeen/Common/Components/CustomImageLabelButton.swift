//
//  CustomImageLabelButton.swift
//  ATeen
//
//  Created by phang on 5/25/24.
//

import UIKit

// MARK: - 이미지 와 라벨이 하나씩 존재하는 버튼
class CustomImageLabelButton: UIButton {
    // MARK: - Public properties
    var imageName: String
    var selectedImageName: String?
    var imageColor: UIColor?
    var selectedImageColor: UIColor?
    var textColor: UIColor
    var labelText: String
    var buttonBackgroundColor: UIColor
    var labelFont: UIFont
    
    lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName) ?? UIImage(systemName: imageName)
        if let imageColor = imageColor {
            imageView.tintColor = imageColor
        }
        return imageView
    }()
    
    lazy var customLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = labelText
        label.textColor = textColor
        label.font = labelFont
        return label
    }()
    
    // MARK: - Life Cycle
    init(
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
        self.imageName = imageName
        self.selectedImageName = selectedImageName
        self.imageColor = imageColor
        self.selectedImageColor = selectedImageColor
        self.textColor = textColor
        self.labelText = labelText
        self.buttonBackgroundColor = buttonBackgroundColor
        self.labelFont = labelFont
        
        super.init(frame: frame)

        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configuration() {
        self.backgroundColor = self.buttonBackgroundColor
        self.addSubview(customImageView)
        self.addSubview(customLabel)
    }
    
    // MARK: - Actions
    func updateImage(for state: UIControl.State) {
        switch state {
        case .selected:
            if let selectedImageName = selectedImageName {
                customImageView.image = UIImage(named: selectedImageName) ?? UIImage(systemName: selectedImageName)
            }
            if let selectedImageColor = selectedImageColor {
                customImageView.tintColor = selectedImageColor
            }
        case .normal:
            customImageView.image = UIImage(named: imageName) ?? UIImage(systemName: imageName)
            if let imageColor = imageColor {
                customImageView.tintColor = imageColor
            }
        default:
            break
        }
    }
}
