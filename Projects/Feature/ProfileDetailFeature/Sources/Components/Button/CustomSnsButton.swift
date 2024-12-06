//
//  CustomSnsButton.swift
//  ProfileDetailFeature
//
//  Created by 노주영 on 11/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import DesignSystem
import UIKit

final class CustomSnsButton: UIButton {
    lazy var snsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(
        frame: CGRect,
        image: UIImage
    ) {
        super.init(frame: frame)
        
        snsImageView.image = image
        self.addSubview(snsImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomSnsButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        snsImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            make.leading.trailing.equalToSuperview().inset(23)
        }
    }
}
