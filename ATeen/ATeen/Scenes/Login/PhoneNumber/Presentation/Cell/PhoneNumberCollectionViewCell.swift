//
//  PhoneNumberCollectionViewCell.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import SnapKit

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
    
    private lazy var certificateButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle(AppLocalized.receiveCertificationCodeButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .main
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
    }
    
    func setDelegate(delegate: PhoneNumberCollectionViewCellDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Actions
    @objc private func didSelectCertificateButton(_ sender: UIButton) {
        delegate?.didSelectCertificateButton()
    }
    // MARK: - Extensions here
    
}

extension PhoneNumberCollectionViewCell: UITextFieldDelegate {
    
}

extension PhoneNumberCollectionViewCell: Reusable { }
