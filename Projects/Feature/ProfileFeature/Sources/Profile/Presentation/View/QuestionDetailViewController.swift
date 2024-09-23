//
//  QuestionDetailViewController.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/3/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol QuestionDetailViewControllerCoordinator: AnyObject {
    func didTabBackButton(
        question: Question,
        index: Int)
}

public final class QuestionDetailViewController: UIViewController {
    // MARK: - Private properties
    private weak var coordinator: QuestionDetailViewControllerCoordinator?
    
    var question: Question
    var index: Int
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: DesignSystemAsset.leftArrowIcon.image,
            style: .done,
            target: self,
            action: #selector(clickBackButton(_:)))
        button.tintColor = UIColor.black
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = question.title
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var writingTextView: UITextView = {
        let textView = UITextView()
        textView.text = question.text
        textView.textContainerInset = UIEdgeInsets(top: 13.0, left: 16.0, bottom: 13.0, right: 16.0)
        textView.font = .customFont(forTextStyle: .callout, weight: .regular)
        textView.showsVerticalScrollIndicator = false
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 2
        textView.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
        textView.delegate = self
        return textView
    }()
    
    public init(
        coordinator: QuestionDetailViewControllerCoordinator,
        question: Question,
        index: Int
    ) {
        self.coordinator = coordinator
        self.question = question
        self.index = index
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        changeTextViewUserInterface()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.systemBackground
        
        navigationItem.leftBarButtonItem = backButton
        
        view.addSubview(titleLabel)
        view.addSubview(writingTextView)
    }
    
    private func configLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(13)
        }
        
        writingTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.height.equalTo(ViewValues.halfHeight)
        }
    }
    
    private func changeTextViewUserInterface() {
        if question.text == "" || question.text == AppLocalized.textViewPlaceHolder {
            writingTextView.layer.borderColor = UIColor.red.cgColor
            writingTextView.textColor = DesignSystemAsset.gray01.color
        } else {
            writingTextView.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
            writingTextView.textColor = UIColor.black
        }
    }
    
    // MARK: - Actions
    @objc private func clickBackButton(_ sender: UIBarButtonItem) {
        coordinator?.didTabBackButton(
            question: question,
            index: index)
    }
}

extension QuestionDetailViewController: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == AppLocalized.textViewPlaceHolder {
            if textView.textColor != .black {
                textView.text = nil
                textView.textColor = .black
            }
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        question.text = textView.text
        
        changeTextViewUserInterface()
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = AppLocalized.textViewPlaceHolder
            textView.textColor = DesignSystemAsset.gray01.color
        }
    }
}
