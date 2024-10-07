//
//  UserChatMessageViewCell.swift
//  ChatFeature
//
//  Created by 김명현 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit


public final class UserChatMessageTableViewCell: UITableViewCell {
    // MARK: - Private properties
    private lazy var chatMessage: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.mainColor.color
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = CACornerMask(
            arrayLiteral: [.layerMinXMinYCorner,
                           .layerMinXMaxYCorner,
                           .layerMaxXMinYCorner]
        )
        
        let label = UILabel()
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 7)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        
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
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUserInterFace()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterFace() {
        contentView.addSubview(chatMessage)
        contentView.addSubview(timeLable)
    }
    
    private func configLayout() {
        chatMessage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.lessThanOrEqualTo(216)
            make.bottom.equalToSuperview()
        }
        
        timeLable.snp.makeConstraints { make in
            make.bottom.equalTo(chatMessage)
            make.trailing.equalTo(chatMessage.snp.leading).offset(-13)
        }
    }
    
    func setMessage(_ message: String, _ time: String, _ isHiddenTimeLable: Bool) {
        // chatMessage 뷰 내의 UILabel의 텍스트를 설정합니다.
        if let label = chatMessage.subviews.first as? UILabel {
            label.text = message
            label.sizeToFit()
        }
        timeLable.text = time
        timeLable.isHidden = isHiddenTimeLable
    }
}

// MARK: - Extensions here
extension UserChatMessageTableViewCell: Reusable { }

