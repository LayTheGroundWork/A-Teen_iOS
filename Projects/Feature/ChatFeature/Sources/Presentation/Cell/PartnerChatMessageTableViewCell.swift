//
//  PartnerChatMessageTableViewCell.swift
//  ChatFeature
//
//  Created by 김명현 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

public final class PartnerChatMessageTableViewCell: UITableViewCell {
    // MARK: - Private properties
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.badge5.image
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        
        return imageView
    }()
    
    private lazy var chatMessage: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = CACornerMask(
            arrayLiteral: [.layerMinXMaxYCorner,
                           .layerMaxXMinYCorner,
                           .layerMaxXMaxYCorner]
        )
        
        let label = UILabel()
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 7)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-8)  // 기본 여백
        }
        
        return view
    }()
    
    private lazy var timeLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .systemGray
        lable.font = .systemFont(ofSize: 12, weight: .regular)
        
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUserInterFace()
        configLayout()
    }
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUserInterFace() {
        contentView.addSubview(profileImage)
        contentView.addSubview(chatMessage)
        contentView.addSubview(timeLable)
    }
    
    // MARK: - Helpers
    private func configLayout() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(chatMessage)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.width.equalTo(28)
            make.height.equalTo(33)
        }
        
        chatMessage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.width.lessThanOrEqualTo(216)
            make.bottom.equalToSuperview()
        }
        
        timeLable.snp.makeConstraints { make in
            make.bottom.equalTo(chatMessage)
            make.leading.equalTo(chatMessage.snp.trailing).offset(13)
        }
    }
    
    func setMessage(_ message: String, time: String, isHiddenTimeLabel: Bool, isHiddenProfileImage: Bool) {
        if let label = chatMessage.subviews.first as? UILabel {
            label.text = message
            label.sizeToFit()
        }
        timeLable.text = time
        timeLable.isHidden = isHiddenTimeLabel
        
        profileImage.isHidden = isHiddenProfileImage
        
        // 프로필 이미지가 숨겨졌을 때 chatMessage의 위치 조정
        if isHiddenProfileImage {
            chatMessage.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(5)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding + 28 + 6)
                make.width.lessThanOrEqualTo(216)
                make.bottom.equalToSuperview()
            }
        } else {
            chatMessage.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(5)
                make.leading.equalTo(profileImage.snp.trailing).offset(6)
                make.width.lessThanOrEqualTo(216)
                make.bottom.equalToSuperview()
            }
        }
        
        layoutIfNeeded()
    }
}

// MARK: - Extensions here
extension PartnerChatMessageTableViewCell: Reusable { }

