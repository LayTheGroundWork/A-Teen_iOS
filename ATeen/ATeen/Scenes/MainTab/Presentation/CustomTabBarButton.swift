//
//  CustomTabBarButton.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

final class CustomTabBarButton: UIButton {
    // MARK: - Public properties
    var imageName: String
    var textColor: UIColor
    var labelText: String
    
    // MARK: - lazy properties
    private lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        return imageView
    }()

    private lazy var customLabelView: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = labelText
        label.textColor = textColor
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }()

    // MARK: - Life Cycle
    init(
        imageName: String,
        textColor: UIColor,
        labelText: String,
        frame: CGRect
    ) {
        self.imageName = imageName
        self.textColor = textColor
        self.labelText = labelText
        super.init(frame: frame)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configuration() {
        self.backgroundColor = .clear
        self.addSubview(customImageView)
        self.addSubview(customLabelView)
        
        customImageView.centerX()
        customImageView.setConstraints(bottom: customLabelView.topAnchor, pBottom: 2)
        customImageView.setWidthConstraint(with: 24)
        customImageView.setHeightConstraint(with: 24)
        customLabelView.centerX()
        customLabelView.setConstraints(bottom: self.bottomAnchor, pBottom: 26)
   
    }
}
