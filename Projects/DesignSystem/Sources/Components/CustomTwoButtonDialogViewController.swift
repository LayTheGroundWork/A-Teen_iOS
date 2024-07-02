//
//  CustomTwoButtonDialogViewController.swift
//  ATeen
//
//  Created by phang on 6/7/24.
//

import SnapKit

import Common
import UIKit

open class CustomTwoButtonDialogViewController: UIViewController {
    var dialogImage: UIImage?
    var dialogTitle: String?
    var titleColor: UIColor
    var titleNumberOfLine: Int
    var titleFont: UIFont
    var dialogMessage: String
    var messageColor: UIColor
    var messageNumberOfLine: Int
    var messageFont: UIFont
    var leftButtonText: String
    var leftButtonColor: UIColor
    var rightButtonText: String
    var rightButtonColor: UIColor
    
    // MARK: - Private properties
    private lazy var dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = ViewValues.defaultRadius
        return view
    }()
    
    private lazy var dialogImageView: UIImageView = {
        let imageView = UIImageView()
        // TODO: -
        return imageView
    }()
    
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
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle(leftButtonText, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: .highlighted)
        button.backgroundColor = leftButtonColor
        button.layer.cornerRadius = ViewValues.defaultRadius
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .bold)
        button.setTitle(rightButtonText, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: .highlighted)
        button.backgroundColor = rightButtonColor
        button.layer.cornerRadius = ViewValues.defaultRadius
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftButton, rightButton])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = ViewValues.defaultSpacing
        return stack
    }()
    
    // MARK: - Life Cycle
    public init(
        dialogImage: UIImage? = nil,
        dialogTitle: String? = nil,
        titleColor: UIColor = .black,
        titleNumberOfLine: Int,
        titleFont: UIFont = .customFont(forTextStyle: .callout, weight: .bold),
        dialogMessage: String,
        messageColor: UIColor = DesignSystemAsset.gray02.color,
        messageNumberOfLine: Int,
        messageFont: UIFont = .customFont(forTextStyle: .footnote, weight: .regular),
        leftButtonText: String,
        leftButtonColor: UIColor,
        rightButtonText: String,
        rightButtonColor: UIColor
    ) {
        self.dialogImage = dialogImage
        self.dialogTitle = dialogTitle
        self.titleColor = titleColor
        self.titleNumberOfLine = titleNumberOfLine
        self.titleFont = titleFont
        self.dialogMessage = dialogMessage
        self.messageColor = messageColor
        self.messageNumberOfLine = messageNumberOfLine
        self.messageFont = messageFont
        self.leftButtonText = leftButtonText
        self.leftButtonColor = leftButtonColor
        self.rightButtonText = rightButtonText
        self.rightButtonColor = rightButtonColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        setupActions()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .black.withAlphaComponent(0.5)

        view.addSubview(dialogView)
//        dialogView.addSubview(dialogImageView)
        dialogView.addSubview(titleLabel)
        dialogView.addSubview(messageLabel)
        dialogView.addSubview(leftButton)
        dialogView.addSubview(buttonStackView)
    }
    
    private func configLayout() {
        dialogView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            if dialogTitle == nil {
                make.top.equalToSuperview().offset(50)
            } else {
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
            }
            make.centerX.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints { make in
            make.width.equalTo((ViewValues.width - 32 - 32 - 16) * 0.44)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        leftButton.addTarget(self,
                                action: #selector(clickLeftButton(_:)),
                                for: .touchUpInside)
        rightButton.addTarget(self,
                                action: #selector(clickRightButton(_:)),
                                for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc open func clickLeftButton(_ sender: UIButton) {
        // overriding 해서 사용
    }
    
    @objc open func clickRightButton(_ sender: UIButton) {
        // overriding 해서 사용
    }
}
