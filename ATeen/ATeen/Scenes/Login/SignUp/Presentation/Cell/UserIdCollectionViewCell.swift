//
//  UserIdCollectionViewCell.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import SnapKit

import UIKit

final class UserIdCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
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
    private lazy var textField: UITextField = {
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
    
    // 문자 길이 표시 레이블
    private lazy var charCountLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.idCountText
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        label.textColor = .black
        label.text = "0/11"
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
}

// MARK: - UITextFieldDelegate
extension UserIdCollectionViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }

        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if updatedText.count > 11 {
            return false
        }
        
        if containsSpecialCharacterOrUppercase(updatedText) || updatedText.count < 4 {
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            textField.layer.borderColor = UIColor.main.cgColor
            
        }
        
        charCountLabel.text = "\(updatedText.count)/11"
        
        return true
    }
    
    // 특수문자 또는 대문자 포함 여부 확인
    private func containsSpecialCharacterOrUppercase(_ text: String) -> Bool {
        let specialCharacterOrUppercaseRegex = "[^a-z0-9]"
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: specialCharacterOrUppercaseRegex)
        let hasSpecialCharacterOrUppercase = regex.firstMatch(in: text, options: [], range: range) != nil
        return hasSpecialCharacterOrUppercase
    }
}

extension UserIdCollectionViewCell: Reusable { }
