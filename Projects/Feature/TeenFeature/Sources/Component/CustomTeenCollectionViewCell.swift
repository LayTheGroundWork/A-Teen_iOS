//
//  CustomTeenCollectionViewCell.swift
//  TeenFeature
//
//  Created by 강치우 on 7/21/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit
import UIKit

class CustomTeenCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let label = UILabel()
    private let button = UIButton()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var buttonAction: (() -> Void)?
    
    func configure(with image: UIImage?, text: String, buttonAction: @escaping () -> Void) {
        imageView.image = image
        label.text = text
        self.buttonAction = buttonAction
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
}
