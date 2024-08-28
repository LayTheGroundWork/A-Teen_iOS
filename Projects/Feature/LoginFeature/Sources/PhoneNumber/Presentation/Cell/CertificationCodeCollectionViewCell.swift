//
//  CertificationCodeCollectionViewCell.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public enum RegistrationStatus {
    case signedUp
    case notSignedUp
    case inValidCodeNumber
}

public protocol CertificationCodeCollectionViewCellDelegate: AnyObject {
    func didSelectNextButton(registrationStatus: RegistrationStatus)
}

public final class CertificationCodeCollectionViewCell: UICollectionViewCell {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private weak var delegate: CertificationCodeCollectionViewCellDelegate?
    private weak var timer: Timer?
    private var totalTime = 180
    private var viewModel: PhoneNumberViewModel?

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
        button.setTitleColor(DesignSystemAsset.gray02.color, for: .disabled)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = DesignSystemAsset.gray03.color
        button.layer.cornerRadius = ViewValues.defaultRadius
        button.isEnabled = false
        return button
    }()
    
    private lazy var resendLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.resendText
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = DesignSystemAsset.gray02.color
        return label
    }()
    
    private lazy var resendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppLocalized.resendButtonText, for: .normal)
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        button.setTitleColor(DesignSystemAsset.mainColor.color, for: .normal)
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
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = formatTime(totalTime)
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var textFields = [UITextField]()
    private lazy var bottomLines = [UIView]()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
        configLayout()
        setupActions()
        startTimer()
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
        self.contentView.addSubview(timerLabel)
        
        for i in 0..<6 {
            let textField = CustomTextField()
            textField.textAlignment = .center
            textField.font = UIFont.customFont(forTextStyle: .largeTitle, weight: .bold)
            textField.textColor = .black
            textField.tintColor = DesignSystemAsset.mainColor.color
            textField.keyboardType = .numberPad
            textField.delegate = self
            textField.tag = i + 1
            
            let bottomLine = UIView()
            bottomLine.backgroundColor = DesignSystemAsset.gray03.color
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
            make.width.equalTo(ViewValues.defaultButtonWidth)
            make.height.equalTo(ViewValues.defaultButtonHeight)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(ViewValues.defaultPadding * 2)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
    }
    
    private func setupActions() {
        nextButton.addTarget(self,
                             action: #selector(didSelectNextButton(_: )),
                             for: .touchUpInside)
    }
    
    func setProperty(
        delegate: CertificationCodeCollectionViewCellDelegate,
        viewModel: PhoneNumberViewModel
    ) {
        self.delegate = delegate
        self.viewModel = viewModel
    }
    
    // MARK: - Actions
    @objc private func didSelectNextButton(_ sender: UIButton) {
        
        convertVerificationCode()
//        self.delegate?.didSelectNextButton(registrationStatus: .notSignedUp)
        
        // TODO: - 다음으로 이동할때, 가입된 사용자인지 검증 후 보내주기
        viewModel?.verificationCode { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(.availablePhoneNumber):
                self.stopTimer()
                DispatchQueue.main.async {
                    self.delegate?.didSelectNextButton(registrationStatus: .notSignedUp)
                }
            case .success(.existedUser):
                DispatchQueue.main.async {
                    self.delegate?.didSelectNextButton(registrationStatus: .signedUp)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.delegate?.didSelectNextButton(registrationStatus: .inValidCodeNumber)
                }
            }
        }
    }
    
    @objc private func didSelectResendButton(_ sender: UIButton) {
        viewModel?.requestCode { [weak self] in
            guard let self = self else { return }
            self.resetTimer()
        }
    }
    
    @objc private func updateTimer() {
        if totalTime > 0 {
            totalTime -= 1
            timerLabel.text = formatTime(totalTime)
        } else {
            stopTimer()
            timerLabel.text = "00:00"
            // TODO: - 시간 다 되었을 때, 상황에 맞춰 로직 추가 필요
        }
    }

    // 모든 텍스트 필드가 채워졌는지 확인하고 **다음으로** 버튼을 활성화 또는 비활성화
    private func updateNextButtonState() {
        let allFieldsFilled = textFields.allSatisfy { $0.text?.count == 1 }
        nextButton.isEnabled = allFieldsFilled
        
        if allFieldsFilled {
            nextButton.backgroundColor = .black
        } else {
            nextButton.backgroundColor = DesignSystemAsset.gray03.color
        }
    }
    
    // 텍스트 필드가 채워질 때 마다 라인 색 변경
    private func updateBottomLineColors() {
        for (index, textField) in textFields.enumerated() {
            let bottomLine = bottomLines[index]
            
            if textField.isFirstResponder {
                bottomLine.backgroundColor = DesignSystemAsset.mainColor.color
            } else {
                bottomLine.backgroundColor = textField.text?.isEmpty == false ? DesignSystemAsset.mainColor.color : DesignSystemAsset.gray03.color
            }
        }
    }
    
    // 인증번호 배열에서 문자열로 변환
    private func convertVerificationCode() {
        viewModel?.verificationCode = textFields.reduce(.empty) {
            $0 + ($1.text ?? .empty)
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
    
    // 타이머 초기화
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func resetTimer() {
        totalTime = 180
        timerLabel.text = formatTime(totalTime)
        if timer?.isValid == nil {
            startTimer()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
}

// MARK: - Extensions here

// MARK: - UITextFieldDelegate
extension CertificationCodeCollectionViewCell: UITextFieldDelegate {
    final class CustomTextField: UITextField {
        override public func deleteBackward() {
            if let text = text, text.isEmpty {
                moveToPreviousTextField()
            }
            super.deleteBackward()
        }
        
        private func moveToPreviousTextField() {
            if tag > 1 {
                // 이전 텍스트 필드로 이동
                if let previousTextField = superview?.viewWithTag(tag - 1) as? UITextField {
                    previousTextField.becomeFirstResponder()
                }
            }
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        updateBottomLineColors()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        updateBottomLineColors()
        updateNextButtonState()
    }
    
    public func textField(
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
                    nextTextField.text = ""                 // 이미 값이 있을 경우 지우기
                    nextTextField.becomeFirstResponder()    // 그리고 포커스 이동
                } else {
                    nextTextField.becomeFirstResponder()    // 빈 경우 바로 포커스 이동
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


class WeakTimerTarget {
    weak var target: NSObjectProtocol?
    let selector: Selector

    init(target: NSObjectProtocol, selector: Selector) {
        self.target = target
        self.selector = selector
    }

    @objc func timerDidFire(_ timer: Timer) {
        target?.perform(selector)
    }
}
