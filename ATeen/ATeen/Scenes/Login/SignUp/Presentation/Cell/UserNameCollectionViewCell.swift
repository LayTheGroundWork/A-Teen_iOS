//
//  UserNameCollectionViewCell.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import SnapKit

import UIKit

final class UserNameCollectionViewCell: UICollectionViewCell {
    // MARK: - Public properties
    
    // MARK: - Private properties
    // 환영 메시지 레이블
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.secondWelcomeText
        label.font = UIFont.customFont(forTextStyle: .title3,
                                       weight: .bold)
        label.textColor = .black
        return label
    }()

    // 안내 메시지 레이블
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.nameInstructionText
        label.font = UIFont.customFont(forTextStyle: .title3,
                                       weight: .bold)
        label.textColor = .black
        return label
    }()

    // 텍스트 필드
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.main.cgColor
        textField.backgroundColor = UIColor.white
        textField.textColor = .black
        textField.tintColor = .gray01
        return textField
    }()

    /// 문자 길이 표시 레이블
    private let charCountLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.nameCountText
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        label.text = "0/8"
        label.textColor = .black
        return label
    }()

    // 안내 문구 레이블
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.nameGuideText
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        setupLayout()
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setupLayout() {
        self.contentView.addSubview(welcomeLabel)
        self.contentView.addSubview(instructionLabel)
        self.contentView.addSubview(textField)
        self.contentView.addSubview(charCountLabel)
        self.contentView.addSubview(guideLabel)
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.greaterThanOrEqualTo(self.contentView.snp.trailing).offset(-ViewValues.defaultPadding)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.greaterThanOrEqualTo(self.contentView.snp.trailing).offset(ViewValues.defaultPadding)
        }

        textField.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(ViewValues.defaultPadding)
            make.height.equalTo(50)
        }

        charCountLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.trailing.equalTo(textField)
        }

        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.leading.equalTo(textField)
        }
    }
    
    // MARK: - Actions
    
    // MARK: - Extensions here
    
}

extension UserNameCollectionViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if updatedText.count > 8 {
            return false
        }

        if containsSpecialCharacterOrInvalidLength(updatedText) || isIncompleteKoreanWord(updatedText) {
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            textField.layer.borderColor = UIColor.main.cgColor
        }

        charCountLabel.text = "\(updatedText.count)/8"
        return true
    }
    
    // 특수문자 포함 여부 및 길이 확인
    private func containsSpecialCharacterOrInvalidLength(_ text: String) -> Bool {
        let specialCharacterRegex = "[^a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣]"
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: specialCharacterRegex)
        let hasSpecialCharacter = regex.firstMatch(in: text, options: [], range: range) != nil
        let invalidLength = text.count < 2 || text.count > 8
        return hasSpecialCharacter || invalidLength
    }

    /// 불완전한 한글 단어 확인
    /// ex. ㅅㅏ, ㄹㅏㅇ, ㅐㅎ
    private func isIncompleteKoreanWord(_ text: String) -> Bool {
        let completeKoreanRegex = "^[가-힣]*$"
        let incompleteKoreanRegex = "[ㄱ-ㅎㅏ-ㅣ]"
        
        let completeRegex = try! NSRegularExpression(pattern: completeKoreanRegex)
        let incompleteRegex = try! NSRegularExpression(pattern: incompleteKoreanRegex)
        
        let range = NSRange(location: 0, length: text.utf16.count)
        
        let isCompleteKorean = completeRegex.firstMatch(in: text, options: [], range: range) != nil
        let hasIncompleteKorean = incompleteRegex.firstMatch(in: text, options: [], range: range) != nil
        
        return !isCompleteKorean && hasIncompleteKorean
    }
}

extension UserNameCollectionViewCell: Reusable { }
