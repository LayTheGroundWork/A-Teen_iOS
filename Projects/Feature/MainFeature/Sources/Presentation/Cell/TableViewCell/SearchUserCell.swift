//
//  SearchUserCell.swift
//  MainFeature
//
//  Created by 노주영 on 11/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

class SearchUserCell: UITableViewCell {
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .bold)
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = DesignSystemAsset.gray01.color
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.heartIcon.image, for: .normal)
        return button
    }()
    
    // MARK: - Life Cycle
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProperties(user: User) {
        profileImageView.image =  DesignSystemAsset.badge10.image
        nickNameLabel.text = user.nickName
        idLabel.text = user.uniqueId
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(heartButton)
        contentView.addSubview(nickNameLabel)
        contentView.addSubview(idLabel)
    }
    
    private func configLayout() {
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.width.height.equalTo(36)
        }
        
        heartButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalToSuperview().offset(13)
            make.bottom.equalToSuperview().offset(-13)
            make.width.equalTo(24)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.leading.equalTo(profileImageView.snp.trailing).offset(13)
            make.trailing.equalTo(heartButton.snp.leading).offset(13)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom)
            make.leading.equalTo(profileImageView.snp.trailing).offset(13)
            make.trailing.equalTo(heartButton.snp.leading).offset(13)
        }
    }
}

extension SearchUserCell: Reusable { }
