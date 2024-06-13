//
//  UserNameCollectionViewCell.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import SnapKit

import UIKit

protocol UserNameCollectionViewCellDelegate: AnyObject {
    func didTapNextButtonInKeyboard()
    func updateNextButtonState(_ state: Bool)
}

final class UserNameCollectionViewCell: UICollectionViewCell {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private weak var delegate: UserNameCollectionViewCellDelegate?
    private var errorMessageLabelHeight: Constraint?
    
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
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.main.cgColor
        textField.backgroundColor = UIColor.white
        textField.textColor = .black
        textField.tintColor = .gray01
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        return textField
    }()

    // 에러메세지 표시 레이블
    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .customFont(forTextStyle: .footnote,
                                 weight: .regular)
        label.textColor = .red
        return label
    }()
    
    // 문자 길이 표시 레이블
    private let charCountLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.nameCountText
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
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
        configUserInterface()
        configLayout()
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.contentView.addSubview(welcomeLabel)
        self.contentView.addSubview(instructionLabel)
        self.contentView.addSubview(textField)
        self.contentView.addSubview(errorMessageLabel)
        self.contentView.addSubview(charCountLabel)
        self.contentView.addSubview(guideLabel)
    }
    
    private func configLayout() {
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

        errorMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.leading.equalTo(textField)
            errorMessageLabelHeight = make.height.equalTo(0).constraint
        }
        
        charCountLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.trailing.equalTo(textField)
        }

        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(errorMessageLabel.snp.bottom).offset(10)
            make.leading.equalTo(textField)
        }

    }
        
            
    
    // MARK: - Actions
    func setProperties(delegate: UserNameCollectionViewCellDelegate) {
        self.delegate = delegate
    }
}

// MARK: - Extensions here

// MARK: - UITextFieldDelegate
extension UserNameCollectionViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            textField.layer.borderColor = UIColor.main.cgColor
            errorMessageLabel.text = ""
            errorMessageLabelHeight?.update(offset: 0)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if checkRegex(text),
           text.count >= 2,
           text.count <= 8,
           !isIncompleteKoreanWord(text) {
            textField.layer.borderColor = UIColor.main.cgColor
            delegate?.updateNextButtonState(true)
            errorMessageLabel.text = ""
            errorMessageLabelHeight?.update(offset: 0)
        } else {
            textField.layer.borderColor = UIColor.red.cgColor
            delegate?.updateNextButtonState(false)
            if text.count < 2 {
                errorMessageLabel.text = "2자 이상 입력해주세요."
            } else {
                errorMessageLabel.text = "한글을 바르게 입력해주세요."
            }
            errorMessageLabelHeight?.update(offset: 16)
        }
        charCountLabel.text = "\(text.count)/8"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        guard let currentText = textField.text else { return true }
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if updatedText.count > 8 {
            return false
        }
        guard checkRegex(string) else { return false }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text,
              checkRegex(text),
              text.count >= 2,
              text.count <= 8 else {
            return false
        }
        delegate?.didTapNextButtonInKeyboard()
        return true
    }
    
    // 영어 & 한글 & 숫자
    private func checkRegex(_ text: String) -> Bool {
        let specialCharacterRegex = "^[a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣]"
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: specialCharacterRegex)
        let result = regex.firstMatch(in: text, options: [], range: range) != nil
        return result
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
