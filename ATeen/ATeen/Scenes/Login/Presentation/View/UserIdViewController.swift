//
//  UserIdViewController.swift
//  ATeen
//
//  Created by 강치우 on 5/29/24.
//

import UIKit
import SnapKit

class UserIDViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    // 뒤로 가기 버튼
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        return button
    }()

    // 더보기 버튼
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        return button
    }()

    // 환영 메시지 레이블
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.welcomeText
        label.font = UIFont.customFont(forTextStyle: .title3,
                                       weight: .bold)
        label.textColor = .black
        return label
    }()

    // 안내 메시지 레이블
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.idInstructionText
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
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.gray01
        return textField
    }()

    // 문자 길이 표시 레이블
    private let charCountLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.idCountText
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        label.textColor = .black
        return label
    }()

    // 안내 문구 레이블
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.idGuideText
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        textField.delegate = self
    }

    // MARK: - Helpers
    private func setupLayout() {
        view.addSubview(backButton)
        view.addSubview(moreButton)
        view.addSubview(welcomeLabel)
        view.addSubview(instructionLabel)
        view.addSubview(textField)
        view.addSubview(charCountLabel)
        view.addSubview(guideLabel)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
        }

        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
        }

        textField.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
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
    
    // UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)

        if containsSpecialCharacterOrUppercase(updatedText) || updatedText.count < 4 || updatedText.count > 11 {
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            textField.layer.borderColor = UIColor.main.cgColor
        }

        charCountLabel.text = "\(updatedText.count)/11"
        return true
    }

    // 특수문자 또는 대문자 포함 여부 확인
    private func containsSpecialCharacterOrUppercase(_ text: String) -> Bool {
        let specialCharacterOrUppercaseRegex = "[^a-z0-9ㄱ-ㅎㅏ-ㅣ가-힣]"
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: specialCharacterOrUppercaseRegex)
        let hasSpecialCharacterOrUppercase = regex.firstMatch(in: text, options: [], range: range) != nil
        return hasSpecialCharacterOrUppercase
    }
}

