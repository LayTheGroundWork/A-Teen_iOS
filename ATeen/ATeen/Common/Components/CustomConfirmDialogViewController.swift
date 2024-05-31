//
//  CustomConfirmDialogViewController.swift
//  ATeen
//
//  Created by phang on 5/31/24.
//

import SnapKit

import UIKit

final class CustomConfirmDialogViewController: UIViewController {
    var dialogTitle: String?
    var titleColor: UIColor
    var titleNumberOfLine: Int
    var titleFont: UIFont
    var dialogMessage: String
    var messageColor: UIColor
    var messageNumberOfLine: Int
    var messageFont: UIFont
    var buttonText: String
    
    // MARK: - Private properties
    private lazy var dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
//    private lazy var xmarkButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "xMarkIcon"), for: .normal)
//        return button
//    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = dialogTitle
        label.textColor = titleColor
        label.textAlignment = .center
        label.numberOfLines = titleNumberOfLine
        label.font = titleFont
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = dialogMessage
        label.textColor = messageColor
        label.textAlignment = .center
        label.numberOfLines = messageNumberOfLine
        label.font = messageFont
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle(buttonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .main
        button.layer.cornerRadius = ViewValues.defaultRadius
        return button
    }()
    
    // MARK: - Life Cycle
    init(
        dialogTitle: String? = nil,
        titleColor: UIColor = .black,
        titleNumberOfLine: Int = 1,
        titleFont: UIFont = .customFont(forTextStyle: .callout, weight: .bold),
        dialogMessage: String,
        messageColor: UIColor = .gray02,
        messageNumberOfLine: Int,
        messageFont: UIFont = .customFont(forTextStyle: .footnote, weight: .regular),
        buttonText: String
    ) {
        self.dialogTitle = dialogTitle
        self.titleColor = titleColor
        self.titleNumberOfLine = titleNumberOfLine
        self.titleFont = titleFont
        self.dialogMessage = dialogMessage
        self.messageColor = messageColor
        self.messageNumberOfLine = messageNumberOfLine
        self.messageFont = messageFont
        self.buttonText = buttonText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        setupActions()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.addSubview(dialogView)
//        dialogView.addSubview(xmarkButton)
        dialogView.addSubview(titleLabel)
        dialogView.addSubview(messageLabel)
        dialogView.addSubview(confirmButton)
    }
    
    private func configLayout() {
        dialogView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.center.equalToSuperview()
        }
        
//        xmarkButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.width.height.equalTo(24)
//        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupActions() {
        confirmButton.addTarget(self,
                                action: #selector(clickConfirmButton(_:)),
                                for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func clickConfirmButton(_ sender: UIButton) {
        // TODO: - 다이얼로그 닫기
    }
}
