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

class LinkTableViewCell: UITableViewCell {
    var deleteButtonAction: (() -> Void)?
    
    lazy var linkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.linkIcon.image
        return imageView
    }()
    
    lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(DesignSystemAsset.gray01.color, for: .normal)
        button.titleLabel?.font = .customFont(forTextStyle: .footnote, weight: .regular)
        button.addTarget(self, action: #selector(clickDeleteButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        contentView.addSubview(linkImageView)
        contentView.addSubview(deleteButton)
        contentView.addSubview(linkLabel)
        
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        linkLabel.text = ""
    }
    
    func setLink(link: String) {
        linkLabel.text = link
    }
}

// MARK: - Action
extension LinkTableViewCell {
    @objc func clickDeleteButton(_ sender: UIButton) {
        deleteButtonAction?()
    }
}

extension LinkTableViewCell: Reusable { }
