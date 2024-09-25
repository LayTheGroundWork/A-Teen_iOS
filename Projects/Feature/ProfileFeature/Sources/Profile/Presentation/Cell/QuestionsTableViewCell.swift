//
//  QuestionsTableViewCell.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

class QuestionsTableViewCell: UITableViewCell {
    var deleteButtonAction: (() -> Void)?
    
    lazy var questionBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.xMarkGray01Icon.image, for: .normal)
        button.addTarget(self, action: #selector(clickDeleteButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .subheadline, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var questionTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = DesignSystemAsset.gray01.color
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = DesignSystemAsset.gray03.color
        self.layer.cornerRadius = 10
        
        contentView.addSubview(questionBackgroundView)
        
        questionBackgroundView.addSubview(deleteButton)
        questionBackgroundView.addSubview(questionLabel)
        questionBackgroundView.addSubview(questionTextLabel)
        
        questionBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.height.equalTo(24)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-10)
        }
        
        questionTextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-10)
            make.bottom.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(questionLabel.snp.bottom).offset(13)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setProperties(question: Question) {
        self.questionLabel.text = question.title
        self.questionTextLabel.text = question.text
    }
}

// MARK: - Action
extension QuestionsTableViewCell {
    @objc func clickDeleteButton(_ sender: UIButton) {
        deleteButtonAction?()
    }
}

extension QuestionsTableViewCell: Reusable { }
