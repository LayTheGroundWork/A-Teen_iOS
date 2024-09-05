//
//  ChatRoomWarningTableViewCell.swift
//  ChatFeature
//
//  Created by 김명현 on 8/29/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

public final class ChatRoomWarningTableViewCell: UITableViewCell {
    // MARK: - Private properties
    public var operatingPolicyButtonButtonAction: (() -> Void)?
    
    private lazy var chatRoomWarningBackground: UIView = {
        var view = UIView()
        view.backgroundColor = DesignSystemAsset.gray01.color
        view.layer.cornerRadius = ViewValues.defaultRadius
        
        return view
    }()
    
    private lazy var chatRoomWarningLabel: UILabel = {
        var label = UILabel()
        label.text = AppLocalized.chatWarning
        label.textColor = .white
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 3)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var chatRoomWarningLabel2: UILabel = {
        var label = UILabel()
        label.text = AppLocalized.chatWarning2
        label.textColor = .white
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var chatRoomWarningImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.exclamationMarkIcon.image
        
        return imageView
    }()
    
    private lazy var chatWarningOperatingPolicyButton: UIButton = {
        let button = UIButton()
        button.setTitle("운영정책 보기", for: .normal)
        button.titleLabel?.font = .customFont(forTextStyle: .footnote, weight: .bold)
        button.setUnderline()
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUserInterFace()
        configLayout()
        setButtonActions()
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if chatWarningOperatingPolicyButton.frame.contains(point) {
            return chatWarningOperatingPolicyButton
        }
        return super.hitTest(point, with: event)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterFace() {
        contentView.addSubview(chatRoomWarningBackground)
        chatRoomWarningBackground.addSubview(chatRoomWarningLabel)
        chatRoomWarningBackground.addSubview(chatRoomWarningLabel2)
        chatRoomWarningBackground.addSubview(chatRoomWarningImageView)
        chatRoomWarningBackground.addSubview(chatWarningOperatingPolicyButton)
    }
    
    private func configLayout() {
            chatRoomWarningBackground.snp.makeConstraints { make in
                make.width.equalTo(ViewValues.width * 0.95)
                make.centerX.equalToSuperview()
                make.height.equalTo(137)
            }
            
            chatRoomWarningImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.centerX.equalToSuperview()
            }
            
            chatRoomWarningLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(44)
                make.leading.equalToSuperview().offset(22)
                make.trailing.equalToSuperview().offset(-22)
            }
            
            chatRoomWarningLabel2.snp.makeConstraints { make in
                make.top.equalTo(chatRoomWarningLabel.snp.bottom).offset(4)
                make.leading.equalToSuperview().offset(ViewValues.width * 0.14)
            }
            
            chatWarningOperatingPolicyButton.snp.makeConstraints { make in
                make.top.equalTo(chatRoomWarningLabel2).offset(-7)
                make.leading.equalTo(chatRoomWarningLabel2.snp.trailing).offset(3)
                
            }
        }
    
    private func setButtonActions() {
        chatWarningOperatingPolicyButton.addTarget(self,
                                                   action: #selector(tappedChatWarningOperatingPolicyButton(_:)),
                                                   for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func tappedChatWarningOperatingPolicyButton(_ sender: UIButton) {
        operatingPolicyButtonButtonAction?()
    }
}

// MARK: - Extensions here
extension ChatRoomWarningTableViewCell: Reusable { }
