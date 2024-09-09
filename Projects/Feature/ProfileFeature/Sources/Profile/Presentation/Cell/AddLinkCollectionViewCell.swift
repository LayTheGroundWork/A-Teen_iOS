////
////  AddLinkCollectionViewCell.swift
////  ProfileFeature
////
////  Created by phang on 7/15/24.
////  Copyright © 2024 ATeen. All rights reserved.
////
//
//import SnapKit
//
//import DesignSystem
//import Common
//import UIKit
//
//final class AddLinkCollectionViewCell: UICollectionViewCell {
//    // MARK: - Private properties
//    private var delegate: LinksDialogViewControllerDelegate?
//    private var viewModel: ProfileViewModel?
//    
//    lazy var linkTextField: UITextField = {
//        let textField = createTextField(tag: 1)
//        textField.leftView = leftView
//        textField.leftViewMode = .always
//        return textField
//    }()
//    
//    lazy var linkTitleTextField: UITextField = {
//        let textField = createTextField(tag: 2)
//        textField.keyboardType = .default
//        textField.attributedPlaceholder = NSAttributedString(
//            string: "링크 이름",
//            attributes: [.foregroundColor: DesignSystemAsset.gray01.color])
//        return textField
//    }()
//    
//    // MARK: - Life Cycle
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configUserInterface()
//        configLayout()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Helpers
//    private func configUserInterface() {
//        contentView.addSubview(linkTextField)
//        contentView.addSubview(linkTitleTextField)
//    }
//    
//    private func configLayout() {
//        linkTextField.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.top.equalToSuperview().offset(24)
//            make.height.equalTo(44)
//        }
//        
//        linkTitleTextField.snp.makeConstraints { make in
//            make.top.equalTo(linkTextField.snp.bottom).offset(16)
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.height.equalTo(44)
//        }
//    }
//    
//    func setProperties(
//        delegate: LinksDialogViewControllerDelegate,
//        viewModel: ProfileViewModel
//    ) {
//        self.delegate = delegate
//        self.viewModel = viewModel
//    }
//    
//    private func createTextField(tag: Int) -> UITextField {
//        let textField = UITextField()
//        textField.delegate = self
//        textField.borderStyle = .roundedRect
//        textField.clearButtonMode = .never
//        textField.layer.borderWidth = 2.0
//        textField.layer.cornerRadius = 10
//        textField.layer.borderColor = DesignSystemAsset.gray03.color.cgColor
//        textField.backgroundColor = .white
//        textField.font = .customFont(forTextStyle: .footnote, weight: .regular)
//        textField.textColor = .black
//        textField.tintColor = DesignSystemAsset.gray01.color
//        textField.autocapitalizationType = .none
//        textField.autocorrectionType = .no
//        textField.spellCheckingType = .no
//        textField.returnKeyType = tag == 1 ? .next : .done
//        textField.tag = tag
//        textField.leftView = makeTextFieldLeftView()
//        textField.leftViewMode = .always
//        textField.rightView = makeTextFieldRightView(for: textField)
//        textField.rightViewMode = .whileEditing
//        return textField
//    }
//    
//    
//    
//    // MARK: - Actions
//    @objc private func clickClearTextButton(_ sender: UIButton) {
//        switch sender.tag {
//        case 1:
//            linkTextField.text = ""
//            linkTextField.rightViewMode = .never
//            textFieldDidChangeSelection(linkTextField)
//        case 2:
//            linkTitleTextField.text = ""
//            linkTitleTextField.rightViewMode = .never
//        default:
//            break
//        }
//    }
//    
//    func clearAllTextFields() {
//        linkTextField.text = ""
//        linkTitleTextField.text = ""
//    }
//}
//
//// MARK: - UITextFieldDelegate
//extension AddLinkCollectionViewCell: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        switch textField.tag {
//        case 1:
//            if let text = linkTextField.text,
//               text.isEmpty {
//                linkTextField.rightViewMode = .never
//            }
//        case 2:
//            if let text = linkTitleTextField.text,
//               text.isEmpty {
//                linkTitleTextField.rightViewMode = .never
//            }
//        default:
//            break
//        }
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        switch textField.tag {
//        case 1:
//            if linkTextField.text != "" {
//                linkTextField.rightViewMode = .always
//            } else {
//                linkTextField.rightViewMode = .never
//            }
//        case 2:
//            if linkTitleTextField.text != "" {
//                linkTitleTextField.rightViewMode = .always
//            } else {
//                linkTitleTextField.rightViewMode = .never
//            }
//        default:
//            break
//        }
//    }
//    
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//        if textField.tag == 1,
//           textField.text != "" {
//            // 체크 버튼 색 변경 ( 가능 )
//            delegate?.updateCloseButton(isCheck: true)
//        } else if textField.tag == 1,
//                  textField.text == "" {
//            // 체크 버튼 색 변경 ( 불가능 )
//            delegate?.updateCloseButton(isCheck: false)
//        }
//    }
//    
//    func textField(
//        _ textField: UITextField,
//        shouldChangeCharactersIn range: NSRange,
//        replacementString string: String
//    ) -> Bool {
//        switch textField.tag {
//        case 1:
//            guard let text = linkTextField.text,
//                  let predictRange = Range(range, in: text) else {
//                return true
//            }
//            let predictedText = text.replacingCharacters(in: predictRange, with: string)
//                .trimmingCharacters(in: .whitespacesAndNewlines)
//            
//            if predictedText.isEmpty {
//                linkTextField.rightViewMode = .never
//            } else {
//                linkTextField.rightViewMode = .whileEditing
//            }
//        case 2:
//            guard let text = linkTitleTextField.text,
//                  let predictRange = Range(range, in: text) else {
//                return true
//            }
//            let predictedText = text.replacingCharacters(in: predictRange, with: string)
//                .trimmingCharacters(in: .whitespacesAndNewlines)
//            
//            if predictedText.isEmpty {
//                linkTitleTextField.rightViewMode = .never
//            } else {
//                linkTitleTextField.rightViewMode = .whileEditing
//            }
//        default:
//            break
//        }
//        return true
//    }
//    
//    func textFieldShouldReturn(
//        _ textField: UITextField
//    ) -> Bool {
//        switch textField.tag {
//        case 1:
//            linkTitleTextField.becomeFirstResponder()
//        case 2:
//            contentView.endEditing(true)
//        default:
//            break
//        }
//        return true
//    }
//}
//
//// MARK: - Reusable
//extension AddLinkCollectionViewCell: Reusable { }
