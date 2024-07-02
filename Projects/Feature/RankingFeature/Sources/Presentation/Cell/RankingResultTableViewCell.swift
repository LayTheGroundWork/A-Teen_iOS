//
//  RankingResultTableViewCell.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

final class RankingResultTableViewCell: UITableViewCell {
    let imageWidth = (ViewValues.width - 32) * 0.19
    let imageHeight = (((ViewValues.width - 32) * 0.19) * 1.14)
    
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
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.nightGlass.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = DesignSystemAsset.mainColor.color
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
        background.addSubview(userImageView)
        background.addSubview(userNameLabel)
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
        
        userImageView.snp.makeConstraints { make in
            make.leading.equalTo(rankLabel.snp.trailing).offset(11)
            make.centerY.equalToSuperview()
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageHeight)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(11)
            make.centerY.equalToSuperview()
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
        proportion: Double
    ) {
        rankLabel.text = String(rank)
        userNameLabel.text = userName
        proportionLabel.text = "\(proportion)%"
    }
}

// MARK: - Extensions here
extension RankingResultTableViewCell: Reusable { }
