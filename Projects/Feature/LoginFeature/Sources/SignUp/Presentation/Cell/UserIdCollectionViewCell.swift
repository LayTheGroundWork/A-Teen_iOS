//
//  UserIdCollectionViewCell.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

protocol UserIdCollectionViewCellDelegate: AnyObject {
    func didTapNextButtonInKeyboard()
    func updateNextButtonState(_ state: Bool)
}

final class UserIdCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    private weak var delegate: UserIdCollectionViewCellDelegate?
    private var errorMessageLabelHeight: Constraint?
    private var viewModel: SignUpViewModel?
    
    // 환영 메시지 레이블
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.welcomeText
        label.font = UIFont.customFont(forTextStyle: .title3,
                                       weight: .bold)
        label.textColor = UIColor.black
        return label
    }()
    
    // 안내 메시지 레이블
    private lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.idInstructionText
        label.font = UIFont.customFont(forTextStyle: .title3,
                                       weight: .bold)
        label.textColor = UIColor.black
        return label
    }()
    
    // 텍스트 필드
    private lazy var textField: UITextField = {
        let textField = CustomClearXmarkTextField()
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .never
        textField.rightView = clearTextButton
        textField.rightViewMode = .whileEditing
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.black
        textField.tintColor = DesignSystemAsset.gray01.color
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        return textField
    }()
    
    private lazy var clearTextButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.clearButton.image, for: .normal)
        return button
    }()
    
    // 에러메세지 표시 레이블
    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .customFont(forTextStyle: .footnote,
                                 weight: .regular)
        label.textColor = UIColor.red
        return label
    }()
    
    // 문자 길이 표시 레이블
    private lazy var charCountLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.idCountText
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        label.textColor = UIColor.black
        return label
    }()
    
    // 안내 문구 레이블
    private lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.idGuideText
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 2
        return label
    }()
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.white
        setupLayout()
        setupActions()
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
    
    private func setupActions() {
        textField.addTarget(self,
                            action: #selector(textFieldDidChange),
                            for: .editingChanged)
        
        clearTextButton.addTarget(self,
                                  action: #selector(didSelectClearTextButton(_:)),
                                  for: .touchUpInside)
    }
    
    // MARK: - Actions
    func setProperties(
        delegate: UserIdCollectionViewCellDelegate,
        viewModel: SignUpViewModel
    ) {
        self.delegate = delegate
        self.viewModel = viewModel
    }
    
    func changeLabelByDuplicationCheck() {
        errorMessageLabel.text = AppLocalized.userIDDuplicationCheckErrorMessage
        errorMessageLabelHeight?.update(offset: 16)
    }
    
    @objc private func textFieldDidChange(_ sender: Any?) {
        self.viewModel?.userId = textField.text ?? .empty
    }
    
    @objc private func didSelectClearTextButton(_ sender: UIButton) {
        textField.text?.removeAll()
        textField.rightViewMode = .never
    }
}

// MARK: - UITextFieldDelegate
extension UserIdCollectionViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            textField.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
            errorMessageLabel.text = ""
            errorMessageLabelHeight?.update(offset: 0)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if containsLowercaseOrNumber(text) && text.count >= 4 {
            textField.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
            delegate?.updateNextButtonState(true)
            errorMessageLabel.text = ""
            errorMessageLabelHeight?.update(offset: 0)
        } else {
            textField.layer.borderColor = UIColor.red.cgColor
            delegate?.updateNextButtonState(false)
            if text.count < 4 {
                errorMessageLabel.text = AppLocalized.userIDNumberOfCharactersErrrorMessage
            } else {
                errorMessageLabel.text = AppLocalized.userIDLowercaseLetterOrNumberErrrorMessage
            }
            errorMessageLabelHeight?.update(offset: 16)
        }
        charCountLabel.text = "\(text.count)\(AppLocalized.userIDCount)"
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
            if string.isEmpty { return true }
            guard let currentText = textField.text else { return true }
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            if updatedText.isEmpty {
                textField.rightViewMode = .never
            }  else {
                textField.rightViewMode = .whileEditing
            }
            
            if updatedText.count > 11 {
                return false
            }
            guard containsLowercaseOrNumber(string) else { return false }
            return true
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text,
              containsLowercaseOrNumber(text) else {
            return false
        }
        delegate?.didTapNextButtonInKeyboard()
        return true
    }
    
    // 영어 소문자 또는 숫자 - character 확인
    private func containsLowercaseOrNumber(_ text: String) -> Bool {
        let containsLowcaseOrNumberRegex = ATeenRegex.lowercaseOrNumber
        let regex = try! NSRegularExpression(pattern: containsLowcaseOrNumberRegex)
        let range = NSRange(location: 0, length: text.utf16.count)
        let result = regex.firstMatch(in: text, options: [], range: range) != nil
        return result
    }
}

extension UserIdCollectionViewCell: Reusable { }
