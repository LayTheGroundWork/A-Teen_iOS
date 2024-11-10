//
//  RankingResultTableViewCell.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

final class RankingResultTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = ViewValues.defaultRadius
        return view
    }()
    
    private lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = DesignSystemAsset.mainColor.color
        label.font = .customFont(forTextStyle: .footnote, weight: .bold)
        return label
    }()

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = DesignSystemAsset.mainColor.color
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var userIDLabel: UILabel = {
        let label = UILabel()
        label.textColor = DesignSystemAsset.gray01.color
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var proportionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var chevronImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.rightGrayIcon.image
        return imageView
    }()
    
    // MARK: - Life Cycle
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        configUserInterface()
        configLayout()
        configShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.selectionStyle = .none
        self.backgroundColor = DesignSystemAsset.backgroundColor.color
        
        contentView.addSubview(background)
        background.addSubview(rankLabel)
        background.addSubview(userNameLabel)
        background.addSubview(userIDLabel)
        background.addSubview(proportionLabel)
        background.addSubview(chevronImage)
    }
    
    private func configShadow() {
        background.addDropYShadow(width: ViewValues.width - 32,
                                  height: 95,
                                  color: UIColor.black,
                                  opacity: 0.1,
                                  radius: 6,
                                  offset: CGSize(width: 3, height: 3))
    }
    
    private func configLayout() {
        background.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.bottom.equalToSuperview()
            make.height.equalToSuperview().inset(5)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.centerY.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(rankLabel.snp.trailing).offset(27)
            make.bottom.equalTo(rankLabel.snp.centerY).offset(-2)
        }
    
        userIDLabel.snp.makeConstraints { make in
            make.leading.equalTo(userNameLabel.snp.leading)
            make.top.equalTo(rankLabel.snp.centerY).offset(2)
        }
        
        chevronImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.centerY.equalToSuperview()
        }
        
        proportionLabel.snp.makeConstraints { make in
            make.trailing.equalTo(chevronImage.snp.leading).offset(-14)
            make.centerY.equalToSuperview()
        }
    }
    
    func setProperties(
        rank: Int,
        userName: String,
        userID: String,
        proportion: Double
    ) {
        rankLabel.text = String(rank)
        userNameLabel.text = userName
        userIDLabel.text = userID
        proportionLabel.text = "\(proportion)%"
    }
}

// MARK: - Extensions here
extension RankingResultTableViewCell: Reusable { }
