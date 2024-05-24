//
//  CustomQuestionView.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import SnapKit

import UIKit

class CustomQuestionView: UIView {
    lazy var oneTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    lazy var oneTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(named: "grayTextColor")
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var twoTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    lazy var twoTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(named: "grayTextColor")
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    /*
    lazy var questionOneView: CustomQuestionTextView = {
        let view = CustomQuestionTextView(frame: .zero, index: 1, title: self.questionList[0].title, text: self.questionList[0].text)
        return view
    }()
    
    lazy var questionTwoView: CustomQuestionTextView = {
        let view = CustomQuestionTextView(frame: .zero, index: 1, title: self.questionList[1].title, text: self.questionList[1].text)
        return view
    }()
    
    lazy var questionThreeView: CustomQuestionTextView = {
        let view = CustomQuestionTextView(frame: .zero, index: 1, title: self.questionList[2].title, text: self.questionList[2].text)
        return view
    }()
    
    lazy var questionFourView: CustomQuestionTextView = {
        let view = CustomQuestionTextView(frame: .zero, index: 1, title: self.questionList[3].title, text: self.questionList[3].text)
        return view
    }()
    
    lazy var questionFiveView: CustomQuestionTextView = {
        let view = CustomQuestionTextView(frame: .zero, index: 1, title: self.questionList[4].title, text: self.questionList[4].text)
        return view
    }()
    
    lazy var questionSixView: CustomQuestionTextView = {
        let view = CustomQuestionTextView(frame: .zero, index: 1, title: self.questionList[5].title, text: self.questionList[5].text)
        return view
    }()
    
    lazy var questionSevenView: CustomQuestionTextView = {
        let view = CustomQuestionTextView(frame: .zero, index: 1, title: self.questionList[6].title, text: self.questionList[6].text)
        return view
    }()
    
    lazy var questionEightView: CustomQuestionTextView = {
        let view = CustomQuestionTextView(frame: .zero, index: 1, title: self.questionList[7].title, text: self.questionList[7].text)
        return view
    }()
    
    lazy var questionNineView: CustomQuestionTextView = {
        let view = CustomQuestionTextView(frame: .zero, index: 1, title: self.questionList[8].title, text: self.questionList[8].text)
        return view
    }()
    
    lazy var questionTenView: CustomQuestionTextView = {
        let view = CustomQuestionTextView(frame: .zero, index: 1, title: self.questionList[9].title, text: self.questionList[9].text)
        return view
    }()
     */
    
    init(frame: CGRect, questionList: [Question]) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "grayQuestionCellColor")
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        oneTitleLabel.text = questionList[0].title
        oneTextLabel.text = questionList[0].text
        twoTitleLabel.text = questionList[1].title
        twoTextLabel.text = questionList[1].text
        
        self.addSubview(oneTitleLabel)
        self.addSubview(oneTextLabel)
        self.addSubview(twoTitleLabel)
        self.addSubview(twoTextLabel)
        /*
        let count = questionList.count
        
        if count >= 1 {
            self.addSubview(questionOneView)
        }
        
        if count >= 2 {
            self.addSubview(questionTwoView)
        }
        
        if count >= 3 {
            self.addSubview(questionThreeView)
        }
        
        if count >= 4 {
            self.addSubview(questionFourView)
        }
        
        if count >= 5 {
            self.addSubview(questionFiveView)
        }
        
        if count >= 6 {
            self.addSubview(questionSixView)
        }
        
        if count >= 7 {
            self.addSubview(questionSevenView)
        }
        
        if count >= 8 {
            self.addSubview(questionEightView)
        }
        
        if count >= 9 {
            self.addSubview(questionNineView)
        }
        
        if count >= 10 {
            self.addSubview(questionTenView)
        }
         */
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomQuestionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        oneTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(
                self.oneTitleLabel.textHeight(width: UIScreen.main.bounds.width - 62, font: self.oneTitleLabel.font!, text: self.oneTitleLabel.text!)
            )
        }
        
        oneTextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(self.oneTitleLabel.snp.bottom).offset(7)
            make.height.equalTo(
                self.oneTextLabel.textHeight(width: UIScreen.main.bounds.width - 62, font: self.oneTextLabel.font!, text: self.oneTextLabel.text!)
            )
        }
        
        twoTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(self.oneTextLabel.snp.bottom).offset(16)
            make.height.equalTo(
                self.twoTitleLabel.textHeight(width: UIScreen.main.bounds.width - 62, font: self.twoTitleLabel.font!, text: self.twoTitleLabel.text!)
            )
        }
        
        twoTextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(self.twoTitleLabel.snp.bottom).offset(7)
            make.height.equalTo(
                self.twoTextLabel.textHeight(width: UIScreen.main.bounds.width - 62, font: self.twoTextLabel.font!, text: self.twoTextLabel.text!)
            )
        }
        /*
        let count = self.questionList.count

        questionOneView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(15)
            self.oneHeightAnchor = make.height.equalTo(0).constraint
        }
        self.layoutIfNeeded()
        self.oneHeightAnchor?.update(offset: self.questionOneView.recursiveUnionInDepthFor(view: self.questionOneView).height)
        
        questionTwoView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(self.questionOneView.snp.bottom).offset(16)
            self.twoHeightAnchor = make.height.equalTo(0).constraint
        }
        self.layoutIfNeeded()
        self.twoHeightAnchor?.update(offset: self.questionTwoView.recursiveUnionInDepthFor(view: self.questionTwoView).height)
        
        questionThreeView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(self.questionTwoView.snp.bottom).offset(16)
            self.threeHeightAnchor = make.height.equalTo(0).constraint
        }
        self.layoutIfNeeded()
        self.threeHeightAnchor?.update(offset: self.questionThreeView.recursiveUnionInDepthFor(view: self.questionThreeView).height)
        
        questionFourView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(self.questionThreeView.snp.bottom).offset(16)
            self.fourHeightAnchor = make.height.equalTo(0).constraint
        }
        self.layoutIfNeeded()
        self.threeHeightAnchor?.update(offset: self.questionFourView.recursiveUnionInDepthFor(view: self.questionFourView).height)
        /*
        if count >= 5 {
            questionFiveView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().offset(-15)
                make.top.equalTo(self.questionFourView.snp.bottom).offset(16)
                self.fiveHeightAnchor = make.height.equalTo(0).constraint
            }
            self.layoutIfNeeded()
            self.fiveHeightAnchor?.update(offset: self.questionFiveView.recursiveUnionInDepthFor(view: self.questionFiveView).height)
        }
        
        if count >= 6 {
            questionSixView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().offset(-15)
                make.top.equalTo(self.questionFiveView.snp.bottom).offset(16)
                self.sixHeightAnchor = make.height.equalTo(0).constraint
            }
            self.layoutIfNeeded()
            self.sixHeightAnchor?.update(offset: self.questionSixView.recursiveUnionInDepthFor(view: self.questionSixView).height)
        }
        
        if count >= 7 {
            questionSevenView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().offset(-15)
                make.top.equalTo(self.questionSixView.snp.bottom).offset(16)
                self.sevenHeightAnchor = make.height.equalTo(0).constraint
            }
            self.layoutIfNeeded()
            self.sevenHeightAnchor?.update(offset: self.questionSevenView.recursiveUnionInDepthFor(view: self.questionSevenView).height)
        }
        
        if count >= 8 {
            questionEightView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().offset(-15)
                make.top.equalTo(self.questionSevenView.snp.bottom).offset(16)
                self.eightHeightAnchor = make.height.equalTo(0).constraint
            }
            self.layoutIfNeeded()
            self.eightHeightAnchor?.update(offset: self.questionEightView.recursiveUnionInDepthFor(view: self.questionEightView).height)
        }
        
        if count >= 9 {
            questionNineView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().offset(-15)
                make.top.equalTo(self.questionEightView.snp.bottom).offset(16)
                self.nineHeightAnchor = make.height.equalTo(0).constraint
            }
            self.layoutIfNeeded()
            self.nineHeightAnchor?.update(offset: self.questionNineView.recursiveUnionInDepthFor(view: self.questionNineView).height)
        }
        
        if count >= 10 {
            questionTenView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().offset(-15)
                make.top.equalTo(self.questionNineView.snp.bottom).offset(16)
                self.tenHeightAnchor = make.height.equalTo(0).constraint
            }
            self.layoutIfNeeded()
            self.tenHeightAnchor?.update(offset: self.questionTenView.recursiveUnionInDepthFor(view: self.questionTenView).height)
        }
         */*/
    }
}


