//
//  ChatRoomModalTableViewCell.swift
//  ChatFeature
//
//  Created by 김명현 on 8/6/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

final class ChatRoomModalTableViewCell: UITableViewCell {
    // MARK: - Private properties
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
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
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
    
    func configure(title: String, image: UIImage?, color: UIColor) {
        titleLabel.text = title
        iconImageView.image = image
        titleLabel.textColor = color
        iconImageView.tintColor = color
    }
}

// MARK: - Extensions here
extension ChatRoomModalTableViewCell: Reusable { }
