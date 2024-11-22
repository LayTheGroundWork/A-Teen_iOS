//
//  IntroduceMbtiButtonCollectionViewCell.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

final class IntroduceMbtiButtonCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    lazy var customAlphabetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = DesignSystemAsset.mainColor.color
        label.font = .customFont(forTextStyle: .callout, weight: .bold)
        return label
    }()
    
    lazy var customtextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = DesignSystemAsset.mainColor.color
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
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
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = DesignSystemAsset.gray03.color.cgColor
        
        contentView.addSubview(customAlphabetLabel)
        contentView.addSubview(customtextLabel)
    }
    
    private func configLayout() {
        customAlphabetLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contentView.snp.centerY).offset(-1)
        }
        
        customtextLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(contentView.snp.centerY).offset(1)
        }
    }
    
    func setProperties(
        alphabet: String,
        text: String
    ) {
        customAlphabetLabel.text = alphabet
        customtextLabel.text = text
    }
    
    func selectCell() {
        contentView.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
    }
    
    func clearCell() {
        contentView.layer.borderColor = DesignSystemAsset.gray03.color.cgColor
    }
}

extension IntroduceMbtiButtonCollectionViewCell: Reusable { }
