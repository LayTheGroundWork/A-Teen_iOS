//
//  ChatRoomCell.swift
//  ChatingFeature
//
//  Created by 김명현 on 6/28/24.
//

import Common
import DesignSystem
import UIKit

public final class ChatRoomCell: UITableViewCell {
    // MARK: - Private properties
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var unreadCountLabel: UIView = {
        let background = UIView()
        background.backgroundColor = .blue
        background.layer.cornerRadius = 12
        background.layer.masksToBounds = true
        
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        
        background.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return background
    }()
    
    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        confingUserInterFace()
        confingLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func confingUserInterFace() {
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(unreadCountLabel)
    }
    
    private func confingLayout() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(18)
            make.leading.equalTo(contentView.snp.leading).offset(33)
            make.width.equalTo(42)
            make.height.equalTo(49)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top)
            make.leading.equalTo(profileImage.snp.trailing).offset(15)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(profileImage.snp.trailing).offset(15)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel)
            make.trailing.equalTo(contentView.snp.trailing).offset(-18)
        }
        
        unreadCountLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.trailing.equalTo(contentView.snp.trailing).offset(-18)
            make.width.equalTo(22)
            make.height.equalTo(22)
        }
    }
    
    func configure(_ chatRoom: ChatModel) {
        profileImage.image = chatRoom.profileImageName
        nameLabel.text = chatRoom.name
        messageLabel.text = chatRoom.lastMessage
        timeLabel.text = chatRoom.lastMessageTime
        if let label = unreadCountLabel.subviews.first as? UILabel {
            label.text = "\(chatRoom.unreadCount)"
        }
    }
}

// MARK: - Extensions here
extension ChatRoomCell: Reusable { }


