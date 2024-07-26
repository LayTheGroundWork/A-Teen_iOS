//
//  LinkTableViewCell.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/12/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

final class LinkTableViewCell: UITableViewCell {
    var deleteButtonAction: (() -> Void)?
    
    private lazy var linkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.linkIcon.image
        return imageView
    }()
    
    private lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(DesignSystemAsset.gray01.color, for: .normal)
        button.titleLabel?.font = .customFont(forTextStyle: .footnote, weight: .regular)
        button.addTarget(self, action: #selector(clickDeleteButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        linkLabel.text = ""
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.addSubview(linkImageView)
        contentView.addSubview(deleteButton)
        contentView.addSubview(linkLabel)
    }
    
    private func configLayout() {
        linkImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        linkLabel.snp.makeConstraints { make in
            make.leading.equalTo(linkImageView.snp.trailing).offset(4)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(24)
        }
    }
    
    func setLink(link: String, title: String?) {
        if let title = title {
            let text = "\(title) | \(link)"
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(.foregroundColor,
                                       value: DesignSystemAsset.gray01.color,
                                       range: (text as NSString).range(of: "|"))
            linkLabel.attributedText = attributedStr
        } else {
            linkLabel.text = link
        }
    }
}

// MARK: - Action
extension LinkTableViewCell {
    @objc func clickDeleteButton(_ sender: UIButton) {
        deleteButtonAction?()
    }
}

extension LinkTableViewCell: Reusable { }
