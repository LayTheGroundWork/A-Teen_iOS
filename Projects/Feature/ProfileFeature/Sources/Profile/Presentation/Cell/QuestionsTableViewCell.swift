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
    lazy var questionBackgroundView: UIView = {
        let view = UIView()
        return view
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
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = DesignSystemAsset.gray03.color
        self.layer.cornerRadius = 10
        
        contentView.addSubview(questionBackgroundView)
        
        questionBackgroundView.addSubview(questionLabel)
        questionBackgroundView.addSubview(questionTextLabel)
        
        questionBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        questionTextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
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

extension QuestionsTableViewCell: Reusable { }
