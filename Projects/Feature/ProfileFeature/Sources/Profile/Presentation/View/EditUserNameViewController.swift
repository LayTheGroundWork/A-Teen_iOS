//
//  EditUserNameViewController.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol EditUserNameViewControllerCoordinator: AnyObject {
    func didTabBackButton()
    func configTabbarState(view: ProfileFeatureViewNames)
}

public final class EditUserNameViewController: UIViewController {
    // MARK: - Private properties
    private var viewModel: EditUserNameViewModel
    private weak var coordinator: EditUserNameViewControllerCoordinator?
    
    private var errorMessageLabelHeight: Constraint?
    
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
        label.text = "닉네임 수정"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    // 텍스트 필드
    lazy var textField: UITextField = {
        let textField = CustomClearXmarkTextField()
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.black
        textField.tintColor = DesignSystemAsset.gray01.color
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = clearTextButton
        textField.rightViewMode = .whileEditing
        textField.delegate = self
        return textField
    }()
    
    private lazy var paddingView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        return view
    }()
    
    private lazy var clearTextButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.clearButton.image, for: .normal)
        button.addTarget(self, action: #selector(didSelectClearTextButton(_:)), for: .touchUpInside)
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
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        label.textColor = UIColor.black
        return label
    }()
    
    // 안내 문구 레이블
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "특수문자를 제외한 한글/영어/숫자 (2~8자리)"
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .customFont(forTextStyle: .callout, weight: .regular)
        button.setTitle(AppLocalized.completeEdit, for: .normal)
        button.setTitle(AppLocalized.completeEdit, for: .disabled)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(DesignSystemAsset.gray02.color, for: .disabled)
        button.backgroundColor = DesignSystemAsset.gray03.color
        button.layer.cornerRadius = ViewValues.defaultRadius
        button.isEnabled = false
        button.addTarget(self, action: #selector(clickSaveButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.configTabbarState(view: .another)
    }
    
    public init(
        viewModel: EditUserNameViewModel,
        coordinator: EditUserNameViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
        
        self.textField.text = viewModel.changeUserName
        self.charCountLabel.text = "\(viewModel.changeUserName.count)\(AppLocalized.userNameCount)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.systemBackground
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = backButton
        
        view.addSubview(titleLabel)
        view.addSubview(textField)
        view.addSubview(errorMessageLabel)
        view.addSubview(charCountLabel)
        view.addSubview(guideLabel)
        view.addSubview(saveButton)
    }
    
    private func configLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(13)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
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
        
        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(-48)
            make.width.equalTo(116)
            make.height.equalTo(50)
        }
    }
    
    private func changeCheckTextField(text: String) {
        if viewModel.checkChangeUserName(text: text) {
            saveButton.isEnabled = true
            saveButton.backgroundColor = UIColor.black
            textField.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
            errorMessageLabel.text = ""
            errorMessageLabelHeight?.update(offset: 0)
        } else {
            saveButton.isEnabled = false
            saveButton.backgroundColor = DesignSystemAsset.gray03.color
            textField.layer.borderColor = UIColor.red.cgColor
            charCountLabel.text = "\(text.count)\(AppLocalized.userNameCount)"
            
            if text.count < 2 {
                errorMessageLabel.text = AppLocalized.userNameNumberErrrorMessage
                errorMessageLabelHeight?.update(offset: 16)
            } else {
                if viewModel.userName == text {
                    textField.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
                    errorMessageLabel.text = ""
                    errorMessageLabelHeight?.update(offset: 0)
                } else {
                    errorMessageLabel.text = AppLocalized.userNameIncorrectKoreanErrorMessage
                    errorMessageLabelHeight?.update(offset: 16)
                }
            }
        }
    }
    
    // MARK: - Actions
    @objc private func clickBackButton(_ sender: UIBarButtonItem) {
        coordinator?.didTabBackButton()
    }
    
    @objc private func didSelectClearTextButton(_ sender: UIButton) {
        textField.text?.removeAll()
        textField.rightViewMode = .never
        changeCheckTextField(text: "")
    }
    
    @objc private func clickSaveButton(_ sender: UIButton) {
        print(viewModel.changeUserName)
    }
}

// MARK: - UITextFieldDelegate
extension EditUserNameViewController: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            textField.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
            errorMessageLabel.text = ""
            errorMessageLabelHeight?.update(offset: 0)
        }
    }
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        changeCheckTextField(text: text)
    }
    
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        print("123")
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
        
        guard viewModel.checkRegex(string) else { return false }
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text,
              viewModel.checkRegex(text),
              text.count >= 2,
              text.count <= 8 else {
            return false
        }
        return true
    }
}
