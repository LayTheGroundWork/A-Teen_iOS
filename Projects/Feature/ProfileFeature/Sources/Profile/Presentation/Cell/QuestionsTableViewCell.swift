//
//  QuestionsTableViewCell.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/18/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

class QuestionsTableViewCell: UITableViewCell {
    private var viewModel: QuestionsViewModel?
    
    var index: Int = 0
    var deleteButtonAction: (() -> Void)?
    
    private let textViewPlaceHolder = "질문에 관한 간단한 답을 작성해주세요"
    
    lazy var questionBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.gray03.color
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.aboutATeen
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .bold)
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.xMarkGray01Icon.image, for: .normal)
        button.addTarget(self, action: #selector(clickDeleteButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var writingTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 13.0, left: 16.0, bottom: 13.0, right: 16.0)
        textView.font = .customFont(forTextStyle: .callout, weight: .regular)
        textView.showsVerticalScrollIndicator = false
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 2
        textView.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
        textView.delegate = self
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        contentView.addSubview(questionBackgroundView)
        contentView.addSubview(writingTextView)
        
        questionBackgroundView.addSubview(deleteButton)
        questionBackgroundView.addSubview(questionLabel)
        
        questionBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(44)
        }
        
        writingTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
            make.top.equalTo(questionBackgroundView.snp.bottom).offset(7)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setProperties(viewModel: QuestionsViewModel, index: Int) {
        self.viewModel = viewModel
        self.index = index
        self.questionLabel.text = "\(String(index + 1)). \(viewModel.questionList[index].title)"
        
        if viewModel.questionList[index].title == "" {
            writingTextView.layer.borderColor = UIColor.red.cgColor
            writingTextView.text = textViewPlaceHolder
        } else {
            writingTextView.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
            writingTextView.text = viewModel.questionList[index].text
        }
    }
}

// MARK: - Action
extension QuestionsTableViewCell {
    @objc func clickDeleteButton(_ sender: UIButton) {
        deleteButtonAction?()
    }
}

//MARK: - UITextViewDelegate
extension QuestionsTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            if textView.textColor != .black {
                textView.text = nil
                textView.textColor = .black
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel?.changeQuestionList[index].text = textView.text
        
        if textView.text == "" {
            textView.layer.borderColor = UIColor.red.cgColor
        } else {
            textView.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = DesignSystemAsset.gray01.color
        }
    }
}

extension QuestionsTableViewCell: Reusable { }
