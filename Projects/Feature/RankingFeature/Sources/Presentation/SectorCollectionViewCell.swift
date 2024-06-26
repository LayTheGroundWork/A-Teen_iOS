//
//  SectorCollectionViewCell.swift
//  RankingFeature
//
//  Created by 김명현 on 6/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

class SectorCollectionViewCell: UICollectionViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = ViewValues.defaultRadius
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.whiteGlass.image
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
     lazy var voteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("투표 참여하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        button.backgroundColor = .black.withAlphaComponent(0.3)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
     lazy var winnerBackgroundView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.layer.cornerRadius = 15
        
        return view
    }()
    
     lazy var winnerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        if let crownImage = UIImage(systemName: "crown.fill") {
            let attachment = NSTextAttachment()
            attachment.image = crownImage.withTintColor(.white)
            attachment.bounds = CGRect(x: 0, y: -3, width: 20, height: 20)
            
            let attachmentString = NSAttributedString(attachment: attachment)
            let textString = NSAttributedString(string: " 1회 우승자")
            
            let completeText = NSMutableAttributedString()
            completeText.append(attachmentString)
            completeText.append(textString)
            
            label.attributedText = completeText
        } else {
            label.text = "1회 우승자"
        }
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUserInterface() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(voteButton)
        containerView.addSubview(winnerBackgroundView)
        winnerBackgroundView.addSubview(winnerLabel)
    }
    
    private func configLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        voteButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-22)
            make.height.equalTo(50)
        }
        
        winnerBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(34)
        }
        
        winnerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    
    @objc private func buttonTapped() {
        print("Button tapped")
    }
}

extension SectorCollectionViewCell: Reusable { }


