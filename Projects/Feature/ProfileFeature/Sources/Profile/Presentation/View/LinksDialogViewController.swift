//
//  LinksDialogViewController.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol LinksDialogViewControllerCoordinator: AnyObject {
    func didFinish()
}

final class LinksDialogViewController: UIViewController {
    // MARK: - Private properties
    private var viewModel: ProfileViewModel
    private weak var coordinator: LinksDialogViewControllerCoordinator?
    
    private lazy var dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = ViewValues.defaultRadius
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 링크"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .bold)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.xMarkIcon.image, for: .normal)
        button.addTarget(self, action: #selector(clickCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.grayCheckIcon.image, for: .normal)
        button.addTarget(self, action: #selector(clickCheckButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var instagramTextField = makeTextField(tag: 0, image: DesignSystemAsset.instagramLogo.image)
    private lazy var xTextField = makeTextField(tag: 1, image: DesignSystemAsset.xLogo.image)
    private lazy var tiktokTextField = makeTextField(tag: 2, image: DesignSystemAsset.tiktokLogo.image)
    private lazy var youtubeTextField = makeTextField(tag: 3, image: DesignSystemAsset.youtubeLogo.image)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.instagramTextField, self.xTextField, self.tiktokTextField, self.youtubeTextField
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()

    init(
        viewModel: ProfileViewModel,
        coordinator: LinksDialogViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        self.viewModel.changeLinks = self.viewModel.userLinks
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(dialogView)

        dialogView.addSubview(titleLabel)
        dialogView.addSubview(closeButton)
        dialogView.addSubview(checkButton)
        dialogView.addSubview(stackView)
    }
    
    private func configLayout() {
        dialogView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.centerY.equalToSuperview()
            make.height.equalTo(341)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(24)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(24)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-33)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
    }
    
    private func makeTextField(tag: Int, image: UIImage) -> UITextField {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "@A-Teen"
        textField.text = viewModel.changeLinks[tag]
        textField.textColor = .black
        textField.tintColor = DesignSystemAsset.gray01.color
        textField.font = .customFont(forTextStyle: .footnote, weight: .regular)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.tag = tag
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = DesignSystemAsset.gray03.color.cgColor
        textField.leftView = makeTextFieldLeftView(image: image)
        textField.leftViewMode = .always
        textField.rightView = makeTextFieldRightView(for: textField)
        textField.rightViewMode = .whileEditing
        return textField
    }
    
    private func makeTextFieldLeftView(image: UIImage) -> UIView {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 14, y: 12, width: 24, height: 24)
        imageView.contentMode = .scaleAspectFit
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 46, height: 48))
        view.addSubview(imageView)
        return view
    }
    
    private func makeTextFieldRightView(for textField: UITextField) -> UIView {
        let clearTextButton = UIButton(frame: CGRect(x: 10, y: 15, width: 20, height: 20))
        clearTextButton.setImage(DesignSystemAsset.clearButton.image, for: .normal)
        clearTextButton.tag = textField.tag
        clearTextButton.addTarget(self, action: #selector(clickClearTextButton(_:)), for: .touchUpInside)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        view.addSubview(clearTextButton)
        return view
    }
    
    private func changeCheckButtonColor(tag: Int, text: String) {
        if viewModel.checkChangeLinks(tag: tag, text: text) {
            checkButton.setImage(DesignSystemAsset.grayCheckIcon.image, for: .normal)
        } else {
            checkButton.setImage(DesignSystemAsset.checkIcon.image, for: .normal)
        }
    }

    // MARK: - Actions
    @objc private func clickCloseButton(_ sender: UIButton) {
        coordinator?.didFinish()
    }
    
    @objc private func clickCheckButton(_ sender: UIButton) {
        viewModel.saveUserLinks()
        coordinator?.didFinish()
    }
    
    @objc private func clickClearTextButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            instagramTextField.text = ""
            instagramTextField.rightViewMode = .never
            
        case 1:
            xTextField.text = ""
            xTextField.rightViewMode = .never
            
        case 2:
            tiktokTextField.text = ""
            tiktokTextField.rightViewMode = .never
            
        case 3:
            youtubeTextField.text = ""
            youtubeTextField.rightViewMode = .never
            
        default:
            break
        }
        changeCheckButtonColor(tag: sender.tag, text: "")
    }
}

// MARK: - UITextFieldDelegate
extension LinksDialogViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            textField.rightViewMode = .never
        } else {
            textField.rightViewMode = .always
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.rightViewMode = .never
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text,
           let range = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: range, with: string)

            if updatedText.isEmpty {
                textField.rightViewMode = .never
            } else {
                textField.rightViewMode = .always
            }
            
            changeCheckButtonColor(tag: textField.tag, text: updatedText)
        }
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
