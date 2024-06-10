//
//  UserIdCollectionViewCell.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import SnapKit

import UIKit

protocol UserIdCollectionViewCellDelegate: AnyObject {
    func didTapNextButtonInKeyboard()
    func updateNextButtonState(_ state: Bool)
}

final class UserIdCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    private weak var delegate: UserIdCollectionViewCellDelegate?
    private var errorMessageLabelHeight: Constraint?

    // 환영 메시지 레이블
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.welcomeText
        label.font = UIFont.customFont(forTextStyle: .title3,
                                       weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // 안내 메시지 레이블
    private lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.idInstructionText
        label.font = UIFont.customFont(forTextStyle: .title3,
                                       weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // 텍스트 필드
    lazy var textField: UITextField = {
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
    private lazy var charCountLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.idCountText
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        label.textColor = .black
        return label
    }()
    
    // 안내 문구 레이블
    private lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.idGuideText
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
        self.contentView.addSubview(errorMessageLabel)
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
    func setProperties(delegate: UserIdCollectionViewCellDelegate) {
        self.delegate = delegate
    }
}

// MARK: - UITextFieldDelegate
extension UserIdCollectionViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            textField.layer.borderColor = UIColor.main.cgColor
            errorMessageLabel.text = ""
            errorMessageLabelHeight?.update(offset: 0)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if containsLowcaseAndNumberInString(text) {
            textField.layer.borderColor = UIColor.main.cgColor
            delegate?.updateNextButtonState(true)
            errorMessageLabel.text = ""
            errorMessageLabelHeight?.update(offset: 0)
        } else {
            textField.layer.borderColor = UIColor.red.cgColor
            delegate?.updateNextButtonState(false)
            if text.count < 4 {
                errorMessageLabel.text = "4자 이상 입력해주세요."
            } else if containsLowcaseInString(text) {
                errorMessageLabel.text = "숫자를 추가해주세요."
            } else {
                errorMessageLabel.text = "영어 소문자를 추가해주세요."
            }
            errorMessageLabelHeight?.update(offset: 16)
        }
        charCountLabel.text = "\(text.count)/11"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        guard let currentText = textField.text else { return true }
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if updatedText.count > 11 {
            return false
        }
        guard containsLowcaseAndNumber(string) else { return false }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text,
              containsLowcaseAndNumberInString(text) else {
            return false
        }
        delegate?.didTapNextButtonInKeyboard()
        return true
    }
    
    // 영어 소문자 & 숫자 - character 확인
    private func containsLowcaseAndNumber(_ text: String) -> Bool {
        let containsLowcaseAndNumberRegex = "^[a-z0-9]"
        let regex = try! NSRegularExpression(pattern: containsLowcaseAndNumberRegex)
        let range = NSRange(location: 0, length: text.utf16.count)
        let result = regex.firstMatch(in: text, options: [], range: range) != nil
        return result
    }
    
    // 영어 소문자 & 숫자 & 4자 이상 11자 이하 - string 전체 확인
    private func containsLowcaseAndNumberInString(_ text: String) -> Bool {
        let containsLowcaseAndNumberRegex = "^(?=.*[a-z])(?=.*[0-9]).{4,11}$"
        let regex = try! NSRegularExpression(pattern: containsLowcaseAndNumberRegex)
        let range = NSRange(location: 0, length: text.utf16.count)
        let result = regex.firstMatch(in: text, options: [], range: range) != nil
        return result
    }
    
    // 영어 소문자 포함 여부 확인
    private func containsLowcaseInString(_ text: String) -> Bool {
        let containsLowcaseRegex = "^[a-z]"
        let regex = try! NSRegularExpression(pattern: containsLowcaseRegex)
        let range = NSRange(location: 0, length: text.utf16.count)
        return regex.firstMatch(in: text, options: [], range: range) != nil
    }

}

extension UserIdCollectionViewCell: Reusable { }
