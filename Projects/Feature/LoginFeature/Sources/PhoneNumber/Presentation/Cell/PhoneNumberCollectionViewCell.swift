//
//  PhoneNumberCollectionViewCell.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import SnapKit

import DesignSystem
import Common
import UIKit

protocol PhoneNumberCollectionViewCellDelegate: AnyObject {
    func didSelectCertificateButton()
}

final class PhoneNumberCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    private weak var delegate: PhoneNumberCollectionViewCellDelegate?
    
    private lazy var inputNumberLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.inputPhoneNumberText
        label.font = UIFont.customFont(forTextStyle: .title3,
                                       weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // 텍스트 필드
    private lazy var textField: UITextField = {
        let textField = CustomClearXmarkTextField()
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.clearButtonMode = .never
        textField.rightView = clearTextButton
        textField.rightViewMode = .whileEditing
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.tintColor = DesignSystemAsset.gray01.color
        return textField
    }()
    
    private lazy var clearTextButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.clearButton.image, for: .normal)
        return button
    }()
    
    private lazy var certificateButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle(AppLocalized.receiveCertificationCodeButton, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(DesignSystemAsset.gray02.color, for: .disabled)
        button.isEnabled = false
        button.backgroundColor = DesignSystemAsset.gray03.color
        button.layer.cornerRadius = ViewValues.defaultRadius
        return button
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(inputNumberLabel)
        self.contentView.addSubview(textField)
        self.contentView.addSubview(certificateButton)
    }
    
    private func configLayout() {
        inputNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.greaterThanOrEqualToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(inputNumberLabel.snp.bottom).offset(38)
            make.leading.trailing.equalToSuperview().inset(ViewValues.defaultPadding)
            make.height.equalTo(44)
        }
        
        certificateButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(80)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
    }
    
    private func setupActions() {
        certificateButton.addTarget(self,
                             action: #selector(didSelectCertificateButton(_: )),
                             for: .touchUpInside)
        clearTextButton.addTarget(self,
                                  action: #selector(didSelectClearTextButton(_:)),
                                  for: .touchUpInside)
    }
    
    func setDelegate(delegate: PhoneNumberCollectionViewCellDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Actions
    @objc private func didSelectCertificateButton(_ sender: UIButton) {
        delegate?.didSelectCertificateButton()
    }
    
    @objc private func didSelectClearTextButton(_ sender: UIButton) {
        textField.text?.removeAll()
        textField.rightViewMode = .never
        updateCertificateButtonState(false)
    }
}

// MARK: - Extensions here
extension PhoneNumberCollectionViewCell {
    private func updateCertificateButtonState(_ state: Bool) {
        if state {
            certificateButton.backgroundColor = DesignSystemAsset.mainColor.color
            certificateButton.isEnabled = true
        } else {
            certificateButton.backgroundColor = DesignSystemAsset.gray03.color
            certificateButton.isEnabled = false
        }
    }
}


// MARK: - UITextFieldDelegate
extension PhoneNumberCollectionViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text,
           text.isEmpty {
            textField.rightViewMode = .never
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text,
           !text.isEmpty {
            textField.rightViewMode = .always
        } else {
            textField.rightViewMode = .never
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text,
           text.count >= 11 {
            updateCertificateButtonState(true)
        } else {
            updateCertificateButtonState(false)
        }
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let regex = "^[0-9]*$"
        guard string.range(of: regex, options: .regularExpression) != nil else { return false }

        guard let text = textField.text, let predictRange = Range(range, in: text) else { return true }
        let predictedText = text.replacingCharacters(in: predictRange, with: string)
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        if predictedText.isEmpty {
            textField.rightViewMode = .never
        } else {
            textField.rightViewMode = .whileEditing
        }
        return true
    }
}

extension PhoneNumberCollectionViewCell: Reusable { }
