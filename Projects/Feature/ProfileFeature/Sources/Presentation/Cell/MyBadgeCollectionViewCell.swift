//
//  MyBadgeCollectionViewCell.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

final class MyBadgeCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    lazy var badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = ViewValues.myBadgeCollectionViewCellwidth / 2
        return imageView
    }()
    
    lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = .customFont(forTextStyle: .footnote, weight: .bold)
        return label
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        badgeImageView.image = nil
        badgeLabel.text = ""
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.addSubview(badgeImageView)
        contentView.addSubview(badgeLabel)
    }
    
    private func configLayout() {
        badgeImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(ViewValues.myBadgeCollectionViewCellwidth)
        }
        
        badgeLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(badgeImageView.snp.bottom).offset(11)
        }
    }
    
    func setProperties(badge: BadgeType) {
        badgeImageView.image = changeBadgeToImage(badge)
        badgeLabel.text = badge.rawValue
    }
    
    private func changeBadgeToImage(_ badgeType: BadgeType) -> UIImage {
        switch badgeType {
        case .badge1:
            DesignSystemAsset.badge1.image
        case .badge2:
            DesignSystemAsset.badge2.image
        case .badge3:
            DesignSystemAsset.badge3.image
        case .badge4, .badge5, .badge6, .badge7, .badge8, .badge9, .badge10, .badge11, .badge12:
            DesignSystemAsset.badge4.image
        }
    }
}

extension MyBadgeCollectionViewCell: Reusable { }

