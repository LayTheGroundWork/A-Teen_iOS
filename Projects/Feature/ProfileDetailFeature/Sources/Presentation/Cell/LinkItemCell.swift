//
//  LinkItemCell.swift
//  ProfileDetailFeature
//
//  Created by 강치우 on 8/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import SnapKit

import UIKit

final class LinkItemCell: UITableViewCell {
    // MARK: - Private properties
    private lazy var linkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.linkBlackIcon.image
        return imageView
    }()
    
    private lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.customFont(forTextStyle: .callout,
                                       weight: .regular)
        return label
    }()
    
    private lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.gray03.color
        return view
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [linkImageView, linkLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Life Cycle
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.addSubview(horizontalStackView)
        contentView.addSubview(divider)
    }
    
    private func configLayout() {
        linkImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(ViewValues.defaultSpacing)
            make.leading.equalToSuperview().inset(31)
            make.trailing.equalToSuperview().inset(ViewValues.defaultSpacing)
        }
        
        divider.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(horizontalStackView.snp.bottom).offset(ViewValues.defaultSpacing)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(with linkItem: LinkItem, showDivider: Bool) {
        linkLabel.text = linkItem.title
        divider.isHidden = !showDivider
    }
}
