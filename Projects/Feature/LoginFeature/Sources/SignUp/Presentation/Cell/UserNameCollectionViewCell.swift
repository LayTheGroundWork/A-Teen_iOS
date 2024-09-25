//
//  UserNameCollectionViewCell.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import SnapKit

import Common
import DesignSystem
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
    private var viewModel: SignUpViewModel?
    
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
    lazy var textField: UITextField = {
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
    private let charCountLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.nameCountText
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        label.textColor = UIColor.black
        return label
    }()
    
    // 안내 문구 레이블
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.nameGuideText
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
        configUserInterface()
        configLayout()
        setupActions()
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
        delegate: UserNameCollectionViewCellDelegate,
        viewModel: SignUpViewModel
    ) {
        self.delegate = delegate
        self.viewModel = viewModel
    }
    
    @objc private func textFieldDidChange(_ sender: Any?) {
        self.viewModel?.userName = textField.text ?? .empty
    }
    
    @objc private func didSelectClearTextButton(_ sender: UIButton) {
        textField.text?.removeAll()
        textField.rightViewMode = .never
    }
}


// MARK: - UITextFieldDelegate
extension UserNameCollectionViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            textField.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
            errorMessageLabel.text = ""
            errorMessageLabelHeight?.update(offset: 0)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text,
              let viewModel = viewModel else {
            return
        }
        if viewModel.checkRegex(text),
           text.count >= 2,
           text.count <= 8,
           !viewModel.isIncompleteKoreanWord(text) {
            textField.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
            delegate?.updateNextButtonState(true)
            errorMessageLabel.text = ""
            errorMessageLabelHeight?.update(offset: 0)
        } else {
            textField.layer.borderColor = UIColor.red.cgColor
            delegate?.updateNextButtonState(false)
            if text.count < 2 {
                errorMessageLabel.text = AppLocalized.userNameNumberErrrorMessage
            } else {
                errorMessageLabel.text = AppLocalized.userNameIncorrectKoreanErrorMessage
            }
            errorMessageLabelHeight?.update(offset: 16)
        }
        charCountLabel.text = "\(text.count)\(AppLocalized.userNameCount)"
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
            
            if updatedText.count > 8 {
                return false
            }
            
            guard let viewModel = viewModel,
                  viewModel.checkRegex(string) else { return false }
            return true
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text,
              let viewModel = viewModel,
              viewModel.checkRegex(text),
              text.count >= 2,
              text.count <= 8 else {
            return false
        }
        delegate?.didTapNextButtonInKeyboard()
        return true
    }
}

extension UserNameCollectionViewCell: Reusable { }
