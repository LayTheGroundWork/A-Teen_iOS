//
//  QuestionsDialogTableViewCell.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

class QuestionsDialogTableViewCell: UITableViewCell {
    private var viewModel: QuestionsViewModel?
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.aboutATeen
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(questionLabel)

        questionLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(ViewValues.defaultPadding)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.questionLabel.text = ""
        self.questionLabel.font = .customFont(forTextStyle: .footnote, weight: .regular)
    }
    
    func setProperties(viewModel: QuestionsViewModel, index: Int) {
        self.viewModel = viewModel
        self.questionLabel.text = "\(String(index + 1)). \(viewModel.sampleQuestionList[index])"
        
        if viewModel.changeQuestionList.contains(where: { $0.question == viewModel.sampleQuestionList[index]}) {
            self.questionLabel.font = .customFont(forTextStyle: .footnote, weight: .bold)
        } else {
            self.questionLabel.font = .customFont(forTextStyle: .footnote, weight: .regular)
        }
    }
}

extension QuestionsDialogTableViewCell: Reusable { }

