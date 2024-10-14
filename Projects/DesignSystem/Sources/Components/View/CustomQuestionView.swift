//
//  CustomQuestionView.swift
//  DesignSystem
//
//  Created by 노주영 on 7/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import Domain
import UIKit

public class CustomQuestionView: UIView {
    public lazy var oneTitleLabel: UILabel = makeTitleLabel()
    public lazy var oneTextLabel: UILabel = makeTextLabel()
    
    public lazy var twoTitleLabel: UILabel = makeTitleLabel()
    public lazy var twoTextLabel: UILabel = makeTextLabel()
    
    lazy var threeTitleLabel: UILabel = makeTitleLabel()
    lazy var threeTextLabel: UILabel = makeTextLabel()
    
    lazy var fourTitleLabel: UILabel = makeTitleLabel()
    lazy var fourTextLabel: UILabel = makeTextLabel()
    
    lazy var fiveTitleLabel: UILabel = makeTitleLabel()
    lazy var fiveTextLabel: UILabel = makeTextLabel()
    
    lazy var sixTitleLabel: UILabel = makeTitleLabel()
    lazy var sixTextLabel: UILabel = makeTextLabel()
    
    lazy var sevenTitleLabel: UILabel = makeTitleLabel()
    lazy var sevenTextLabel: UILabel = makeTextLabel()
    
    lazy var eightTitleLabel: UILabel = makeTitleLabel()
    lazy var eightTextLabel: UILabel = makeTextLabel()
    
    lazy var nineTitleLabel: UILabel = makeTitleLabel()
    lazy var nineTextLabel: UILabel = makeTextLabel()
    
    lazy var tenTitleLabel: UILabel = makeTitleLabel()
    lazy var tenTextLabel: UILabel = makeTextLabel()

    
    public init(frame: CGRect, questionList: [QuestionData]) {
        super.init(frame: frame)
        configUserInterface(questionList: questionList)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Properties
extension CustomQuestionView {
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .bold)
        return label
    }
    
    func makeTextLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = DesignSystemAsset.gray02.color
        label.numberOfLines = 0
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }
}

// MARK: - UI
extension CustomQuestionView {
    func configUserInterface(questionList: [QuestionData]) {
        self.backgroundColor = DesignSystemAsset.gray03.color
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        
        if questionList.count > 2 {
            self.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        for (index, question) in questionList.enumerated() {
            switch index {
            case 0:
                setLabel(
                    titleLabel: oneTitleLabel,
                    textLabel: oneTextLabel,
                    beforeLabel: nil,
                    question: question)
                
            case 1:
                setLabel(
                    titleLabel: twoTitleLabel,
                    textLabel: twoTextLabel,
                    beforeLabel: oneTextLabel,
                    question: question)

            case 2:
                setLabel(
                    titleLabel: threeTitleLabel,
                    textLabel: threeTextLabel,
                    beforeLabel: twoTextLabel,
                    question: question)

            case 3:
                setLabel(
                    titleLabel: fourTitleLabel,
                    textLabel: fourTextLabel,
                    beforeLabel: threeTextLabel,
                    question: question)

            case 4:
                setLabel(
                    titleLabel: fiveTitleLabel,
                    textLabel: fiveTextLabel,
                    beforeLabel: fourTextLabel,
                    question: question)

            case 5:
                setLabel(
                    titleLabel: sixTitleLabel,
                    textLabel: sixTextLabel,
                    beforeLabel: fiveTextLabel,
                    question: question)

            case 6:
                setLabel(
                    titleLabel: sevenTitleLabel,
                    textLabel: sevenTextLabel,
                    beforeLabel: sixTextLabel,
                    question: question)
                
            case 7:
                setLabel(
                    titleLabel: eightTitleLabel,
                    textLabel: eightTextLabel,
                    beforeLabel: sevenTextLabel,
                    question: question)
                
            case 8:
                setLabel(
                    titleLabel: nineTitleLabel,
                    textLabel: nineTextLabel,
                    beforeLabel: eightTextLabel,
                    question: question)

            case 9:
                setLabel(
                    titleLabel: tenTitleLabel,
                    textLabel: tenTextLabel,
                    beforeLabel: nineTextLabel,
                    question: question)

            default:
                break
            }
        }
    }
    
    func setLabel(titleLabel: UILabel, textLabel: UILabel, beforeLabel: UILabel?, question: QuestionData) {
        titleLabel.text = question.question
        textLabel.text = question.answer
        
        self.addSubview(titleLabel)
        self.addSubview(textLabel)
        
        configLabelLayout(
            titleLabel: titleLabel,
            textLabel: textLabel,
            beforeLabel: beforeLabel)
    }
}

// MARK: - Layout
extension CustomQuestionView {
    func configLabelLayout(titleLabel: UILabel, textLabel: UILabel, beforeLabel: UILabel?) {
        if let beforeLabel = beforeLabel {
            titleLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().offset(-15)
                make.top.equalTo(beforeLabel.snp.bottom).offset(16)
                make.height.equalTo(
                    titleLabel.textHeight(width: ViewValues.questionHeight, font: titleLabel.font!, text: titleLabel.text!)
                )
            }
        } else {
            titleLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().offset(-16)
                make.top.equalToSuperview().offset(15)
                make.height.equalTo(
                    titleLabel.textHeight(width: ViewValues.questionHeight, font: titleLabel.font!, text: titleLabel.text!)
                )
            }
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
            make.height.equalTo(
                textLabel.textHeight(width: ViewValues.questionHeight, font: textLabel.font!, text: textLabel.text!)
            )
        }
    }
}
