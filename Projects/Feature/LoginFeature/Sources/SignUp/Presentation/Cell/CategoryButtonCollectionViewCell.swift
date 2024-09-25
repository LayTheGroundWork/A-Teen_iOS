//
//  CategoryButtonCollectionViewCell.swift
//  LoginFeature
//
//  Created by 최동호 on 8/7/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

final class CategoryButtonCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
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
    
    override func prepareForReuse() {
        clearCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = DesignSystemAsset.gray03.color.cgColor
        
        contentView.addSubview(customtextLabel)
    }
    
    private func configLayout() {
        customtextLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-18)
        }
    }
    
    func setProperties(
        text: String
    ) {
        customtextLabel.text = text
    }
    
    func selectCell() {
        contentView.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
    }
    
    func clearCell() {
        contentView.layer.borderColor = DesignSystemAsset.gray03.color.cgColor
    }
}

extension CategoryButtonCollectionViewCell: Reusable { }
