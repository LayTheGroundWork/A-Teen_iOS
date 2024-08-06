//
//  ChatPopOverModalTableViewCell.swift
//  ChatFeature
//
//  Created by 김명현 on 8/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

final class ChatPopOverModalTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = DesignSystemAsset.grayDark.color
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = DesignSystemAsset.grayDark.color
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = DesignSystemAsset.backgroundColor.color
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with title: String, image: UIImage?) {
        titleLabel.text = title
        iconImageView.image = image
    }
}

extension ChatPopOverModalTableViewCell: Reusable { }
