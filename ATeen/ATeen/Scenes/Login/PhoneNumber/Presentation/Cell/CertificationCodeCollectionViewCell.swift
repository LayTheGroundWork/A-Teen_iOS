//
//  CertificationCodeCollectionViewCell.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import SnapKit

import UIKit

enum RegistrationStatus {
    case signedUp
    case notSignedUp
}

protocol CertificationCodeCollectionViewCellDelegate: AnyObject {
    func didSelectNextButton(registrationStatus: RegistrationStatus)
    func didSelectResendCode()
}

final class CertificationCodeCollectionViewCell: UICollectionViewCell {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private weak var delegate: CertificationCodeCollectionViewCellDelegate?
    
    private lazy var inputCodeLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.inputCodeText
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout, weight: .regular)
        button.setTitle(AppLocalized.nextButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = ViewValues.defaultRadius
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    private lazy var resendLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.resendText
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = .gray02
        return label
    }()
    
    private lazy var resendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppLocalized.resendButtonText, for: .normal)
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        button.setTitleColor(.main, for: .normal)
        button.addTarget(self, action: #selector(didSelectResendButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
        
    private var textFields = [UITextField]()
    private var bottomLines = [UIView]()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
        configLayout()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(inputCodeLabel)
        self.contentView.addSubview(stackView)
        self.contentView.addSubview(resendLabel)
        self.contentView.addSubview(resendButton)
        self.contentView.addSubview(nextButton)
        
        for i in 0..<6 {
            let textField = CustomTextField()
            textField.textAlignment = .center
            textField.font = UIFont.customFont(forTextStyle: .largeTitle, weight: .bold)
            textField.textColor = .black
            textField.tintColor = .main
            textField.keyboardType = .numberPad
            textField.delegate = self
            textField.tag = i + 1
            
            let bottomLine = UIView()
            bottomLine.backgroundColor = .gray03
            textField.addSubview(bottomLine)
            
            bottomLine.snp.makeConstraints { make in
                make.height.equalTo(2)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview().offset(8)
            }
            
            stackView.addArrangedSubview(textField)
            textFields.append(textField)
            bottomLines.append(bottomLine)
        }
    }
    
    private func configLayout() {
        inputCodeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.greaterThanOrEqualToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(inputCodeLabel.snp.bottom).offset(55)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.greaterThanOrEqualToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        resendLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(ViewValues.defaultPadding * 2)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.greaterThanOrEqualToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        resendButton.snp.makeConstraints { make in
            make.top.equalTo(resendLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalTo(ViewValues.signUpNextButtonWidth)
            make.height.equalTo(ViewValues.signUpNextButtonHeight)
        }
    }
    
    private func setupActions() {
        nextButton.addTarget(self,
                             action: #selector(didSelectNextButton(_: )),
                             for: .touchUpInside)
    }
    
    func setDelegate(delegate: CertificationCodeCollectionViewCellDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Actions
    @objc private func didSelectNextButton(_ sender: UIButton) {
        // TODO: - 다음으로 이동할때, 가입된 사용자인지 검증 후 보내주기
        let isNotSignedUpUser = true
        if isNotSignedUpUser {      // 가입 가능
            print("가입 가능")
            delegate?.didSelectNextButton(registrationStatus: .notSignedUp)
        } else {                    // 이미 가입된 사용자
            print("이미 가입된 사용자")
            delegate?.didSelectNextButton(registrationStatus: .signedUp)
        }
    }
    
    @objc private func didSelectResendButton(_ sender: UIButton) {
        delegate?.didSelectResendCode()
    }
    
    // 모든 텍스트 필드가 채워졌는지 확인하고 **다음으로** 버튼을 활성화 또는 비활성화
    private func updateNextButtonState() {
        let allFieldsFilled = textFields.allSatisfy { $0.text?.count == 1 }
        nextButton.isEnabled = allFieldsFilled
        nextButton.alpha = allFieldsFilled ? 1.0 : 0.5
    }
    
    // 텍스트 필드가 채워질 때 마다 라인 색 변경
    private func updateBottomLineColors() {
        for (index, textField) in textFields.enumerated() {
            let bottomLine = bottomLines[index]
            
            if textField.isFirstResponder {
                bottomLine.backgroundColor = .main
            } else {
                bottomLine.backgroundColor = textField.text?.isEmpty == false ? .main : .gray03
            }
        }
    }
    
    // 텍스트필드 초기화
    func clearTextFields() {
        for textField in textFields {
            textField.text = ""
        }
        updateBottomLineColors()
        updateNextButtonState()
    }
    
    // MARK: - Extensions here
}

// UITextFieldDelegate
extension CertificationCodeCollectionViewCell: UITextFieldDelegate {
    final class CustomTextField: UITextField {
        override public func deleteBackward() {
            if let text = text, text.isEmpty {
                moveToPreviousTextField()
            }
            super.deleteBackward()
        }
        
        private func moveToPreviousTextField() {
            dump(self)
            if tag > 1 {
                // 이전 텍스트 필드로 이동
                if let previousTextField = superview?.viewWithTag(tag - 1) as? UITextField {
                    previousTextField.becomeFirstResponder()
                }
            }
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateBottomLineColors()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateBottomLineColors()
        updateNextButtonState()
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text,
              let textRange = Range(range, in: text) 
        else {
            return false
        }
        
        // 텍스트가 숫자인지 확인
        guard string.isEmpty ||
                (string.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil)
        else {
            return false
        }

        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        if updatedText.isEmpty {
            textField.text = ""
            if textField.tag > 1 {
                let previousTextField = textFields[textField.tag - 2]
                previousTextField.becomeFirstResponder()
            }
        } else {
            textField.text = String(string.prefix(1))
            // 입력 시 다음 필드로 이동
            if textField.tag < textFields.count {
                let nextTextField = textFields[textField.tag]
                if nextTextField.text?.isEmpty == false {
                    nextTextField.text = "" // 이미 값이 있을 경우 지우기
                    nextTextField.becomeFirstResponder() // 그리고 포커스 이동
                } else {
                    nextTextField.becomeFirstResponder() // 빈 경우 바로 포커스 이동
                }
            } else {
                textField.resignFirstResponder()
            }
        }
        
        // 모든 필드가 채워졌는지 확인하여 버튼 상태 업데이트
        updateNextButtonState()
        
        // 텍스트 필드 밑줄 색상 업데이트
        updateBottomLineColors()
        
        return false
    }
}

extension CertificationCodeCollectionViewCell: Reusable { }
