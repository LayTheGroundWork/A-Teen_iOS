//
//  IntroduceWritingCollectionViewCell.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

final class IntroduceWritingCollectionViewCell: UICollectionViewCell {
    private var viewModel: IntroduceViewModel?
    
    var textViewAction: (() -> Void)?
    
    private let textViewPlaceHolder = "간단한 자기 소개글을 작성해주세요\nex) 저의 취미는 운동이에요"
    
    // MARK: - Private properties
    private lazy var writingLabel: UILabel = {
        let label = UILabel()
        label.text = "당신에 대한 소개 글을 적어주세요."
        label.textColor = DesignSystemAsset.gray02.color
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .callout, weight: .regular)
        return label
    }()
    
    lazy var writingTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        textView.font = .customFont(forTextStyle: .callout, weight: .regular)
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 2
        textView.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
        textView.delegate = self
        return textView
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.addSubview(writingLabel)
        contentView.addSubview(writingTextView)
    }
    
    private func configLayout() {
        writingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalToSuperview()
        }
        
        writingTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(writingLabel.snp.bottom).offset(42)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Properties
extension IntroduceWritingCollectionViewCell {
    public func setProperties(viewModel: IntroduceViewModel) {
        self.viewModel = viewModel
        
        if viewModel.myWriting == "" {
            viewModel.changeWriting = ""
            writingTextView.text = textViewPlaceHolder
            writingTextView.textColor = DesignSystemAsset.gray01.color
        } else {
            viewModel.changeWriting = viewModel.myWriting
            writingTextView.text = viewModel.changeWriting
            writingTextView.textColor = UIColor.black
        }
    }
}

extension IntroduceWritingCollectionViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            if textView.textColor != .black {
                textView.text = nil
                textView.textColor = .black
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel?.changeWriting = textView.text
        
        textViewAction?()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = DesignSystemAsset.gray01.color
        }
    }
}

extension IntroduceWritingCollectionViewCell: Reusable { }


