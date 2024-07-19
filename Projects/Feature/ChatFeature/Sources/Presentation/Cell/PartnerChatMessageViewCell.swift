//
//  PartnerChatMessageViewCell.swift
//  ChatFeature
//
//  Created by 김명현 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import UIKit

final class PartnerChatMessageViewCell: UITableViewCell {
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dog")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        
        return imageView
    }()
    
    private lazy var chatMessage: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = CACornerMask(
            arrayLiteral: [.layerMinXMinYCorner,
                           .layerMaxXMinYCorner,
                           .layerMaxXMaxYCorner]
        )
        
        let label = UILabel()
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 7)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(24)
            
        }
        
        return view
    }()
    
    private lazy var timeLable: UILabel = {
        let lable = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTime = dateFormatter.string(from: Date())
        
        lable.textColor = .systemGray
        lable.font = .systemFont(ofSize: 12, weight: .regular)
        lable.text = currentTime
        
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUserInterFace()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUserInterFace() {
        contentView.addSubview(profileImage)
        contentView.addSubview(chatMessage)
        contentView.addSubview(timeLable)
    }
    
    private func configLayout() {
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(78)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.width.equalTo(28)
            make.height.equalTo(33)
        }
        
        chatMessage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(78)
            make.leading.equalTo(profileImage.snp.trailing).offset(6)
            make.width.equalTo(216)
            make.height.equalTo(52)
        }
        
        timeLable.snp.makeConstraints { make in
            make.bottom.equalTo(chatMessage)
            make.leading.equalTo(chatMessage.snp.trailing).offset(13)
        }
    }
    
    func setMessage(_ message: String, _ time: String, _ isHiddenTimeLabel: Bool) {
        // chatMessage 뷰 내의 UILabel의 텍스트를 설정합니다.
        if let label = chatMessage.subviews.first as? UILabel {
            label.text = message
            label.sizeToFit()
        }
        timeLable.text = time
        timeLable.isHidden = isHiddenTimeLabel
    }
}

extension PartnerChatMessageViewCell: Reusable { }

