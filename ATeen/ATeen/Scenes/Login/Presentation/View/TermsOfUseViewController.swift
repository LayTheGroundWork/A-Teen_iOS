//
//  TermsOfUseViewController.swift
//  ATeen
//
//  Created by phang on 5/28/24.
//

import SnapKit

import UIKit

final class TermsOfUseViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private lazy var termsOfUseLabel: UILabel = {
        let label = UILabel()
        label.text = "사용 약관"
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .title3,
                                       weight: .bold)
        return label
    }()
    
    private lazy var allAgreeLabel: UILabel = {
        let label = UILabel()
        label.text = "모두 동의"
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout,
                                       weight: .regular)
        return label
    }()
    
    private lazy var serviceTermsLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 약관에 동의 (필수)"
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout,
                                       weight: .regular)
        return label
    }()
    
    private lazy var informationAgreeLabel: UILabel = {
        let label = UILabel()
        label.text = "개인 정보 수집 및 사용에 동의 (필수)"
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout,
                                       weight: .regular)
        return label
    }()
    
    private lazy var alarmAgreeLabel: UILabel = {
        let label = UILabel()
        label.text = "인기 콘텐츠 및 알림 수신 동의 (선택)"
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout,
                                       weight: .regular)
        return label
    }()
    
    private lazy var alarmAgreeExplanationLabel: UILabel = {
        let label = UILabel()
        label.text = "A-TEEN에서 인기 콘텐츠 및 프로모션에 대한 알림을 받습니다. 언제든지 설정을 검토하고 편집할 수 있습니다. 동의를 하지 않아도 A-TEEN 서비스 사용이 제한되지 않습니다."
        label.numberOfLines = 4
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        label.textColor = .graySchool
        return label
    }()
    
    private lazy var showServiceDetailButton: CustomShowDetailButton = {
        let button = CustomShowDetailButton()
        return button
    }()
    
    private lazy var showInformationDetailButton: CustomShowDetailButton = {
        let button = CustomShowDetailButton()
        return button
    }()
    
    private lazy var allCheckButton: UIButton = makeCustomCheckButton(tag: 0)
    
    private lazy var serviceCheckButton: UIButton = makeCustomCheckButton(tag: 1)
    
    private lazy var informationCheckButton: UIButton = makeCustomCheckButton(tag: 2)
    
    private lazy var alarmCheckButton: UIButton = makeCustomCheckButton(tag: 3)
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle("다음으로", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = ViewValues.defaultRadius
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        setupActions()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        
        // 모두 동의
        let allCheckStack = UIStackView(
            arrangedSubviews: [allCheckButton, allAgreeLabel])
        allCheckStack.axis = .horizontal
        allCheckStack.alignment = .top
        allCheckStack.spacing = 10
        
        // 서비스 약관 동의
        let serviceTextStack = UIStackView(
            arrangedSubviews: [serviceTermsLabel, showServiceDetailButton])
        serviceTextStack.axis = .vertical
        serviceTextStack.alignment = .leading
        serviceTextStack.spacing = 0
        
        let serviceStack = UIStackView(
            arrangedSubviews: [serviceCheckButton, serviceTextStack])
        serviceStack.axis = .horizontal
        serviceStack.alignment = .top
        serviceStack.spacing = 10
        
        // 개인 정보 수집 동의
        let informationTextStack = UIStackView(
            arrangedSubviews: [informationAgreeLabel, showInformationDetailButton])
        informationTextStack.axis = .vertical
        informationTextStack.alignment = .leading
        informationTextStack.spacing = 0
        
        let informationStack = UIStackView(
            arrangedSubviews: [informationCheckButton, informationTextStack])
        informationStack.axis = .horizontal
        informationStack.alignment = .top
        informationStack.spacing = 10
        
        // 알림 수신 동의
        let alarmTextStack = UIStackView(
            arrangedSubviews: [alarmAgreeLabel, alarmAgreeExplanationLabel])
        alarmTextStack.axis = .vertical
        alarmTextStack.alignment = .leading
        alarmTextStack.spacing = 10
        
        let alarmStack = UIStackView(
            arrangedSubviews: [alarmCheckButton, alarmTextStack])
        alarmStack.axis = .horizontal
        alarmStack.alignment = .top
        alarmStack.spacing = 10
        
        view.addSubview(termsOfUseLabel)
        view.addSubview(nextButton)
        view.addSubview(allCheckStack)
        view.addSubview(serviceStack)
        view.addSubview(informationStack)
        view.addSubview(alarmStack)
        
        termsOfUseLabel.snp.makeConstraints { make in
            // 상단 네비 생기면, make.top.equalTo(네비.snp.bottom).offset(13)
            make.top.equalToSuperview().offset(93)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
        
        allCheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        serviceCheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        informationCheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        alarmCheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        alarmAgreeExplanationLabel.snp.makeConstraints { make in
            make.width.equalTo(ViewValues.width - 72)
        }
        
        allCheckStack.snp.makeConstraints { make in
            make.top.equalTo(termsOfUseLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
        
        serviceStack.snp.makeConstraints { make in
            make.top.equalTo(allCheckStack.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
        
        informationStack.snp.makeConstraints { make in
            make.top.equalTo(serviceStack.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
        
        alarmStack.snp.makeConstraints { make in
            make.top.equalTo(informationStack.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
    }
    
    private func makeCustomCheckButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "grayCheckButton"), for: .normal)
        button.setImage(UIImage(named: "mainCheckButton"), for: .selected)
        button.backgroundColor = .grayQuestionCell // 선택 시, main 으로 변경
        button.layer.cornerRadius = 10
        button.isSelected = false
        button.tag = tag
        return button
    }
    
    private func setupActions() {
        allCheckButton.addTarget(self,
                                 action: #selector(clickButton(_:)),
                                 for: .touchUpInside)
        serviceCheckButton.addTarget(self,
                                     action: #selector(clickButton(_:)),
                                     for: .touchUpInside)
        informationCheckButton.addTarget(self,
                                         action: #selector(clickButton(_:)),
                                         for: .touchUpInside)
        alarmCheckButton.addTarget(self,
                                   action: #selector(clickButton(_:)),
                                   for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func clickButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            didSelectAllCheckButton(sender)
        case 1, 2, 3:
            didSelectCheckButton(sender)
        default:
            break
        }
    }
}

// MARK: - Extension + CustomCheckButton 관련 메서드
extension TermsOfUseViewController {
    private func updateSelectedCustomCheckButtonState(_ button: UIButton) {
        button.isSelected = true
    }
    
    private func updateNotSelectedCustomCheckButtonState(_ button: UIButton) {
        button.isSelected = false
    }
    
    private func updateAllSelectedCustomCheckButtonState() {
        [allCheckButton, serviceCheckButton,
         informationCheckButton, alarmCheckButton].forEach { button in
            button.isSelected = true
        }
    }
    
    private func updateAllNotSelectedCustomCheckButtonState() {
        [allCheckButton, serviceCheckButton,
         informationCheckButton, alarmCheckButton].forEach { button in
            button.isSelected = false
        }
    }
    
    private func verifyAllCustomCheckButtonState() {
        allCheckButton.isSelected = ![serviceCheckButton,
                                      informationCheckButton,
                                      alarmCheckButton].contains { $0.isSelected == false }
    }
    
    private func didSelectAllCheckButton(_ button: UIButton) {
        if button.isSelected {
            updateAllNotSelectedCustomCheckButtonState()
        } else {
            updateAllSelectedCustomCheckButtonState()
        }
    }
    
    private func didSelectCheckButton(_ button: UIButton) {
        if button.isSelected {
            updateNotSelectedCustomCheckButtonState(button)
        } else {
            updateSelectedCustomCheckButtonState(button)
        }
        verifyAllCustomCheckButtonState()
    }
}

// MARK: - Custom Show Detail Button
// TODO: ( 파일 분리 예정 )
final class CustomShowDetailButton: CustomImageLabelButton {
    override init(
        imageName: String = "chevron.right",
        imageColor: UIColor? = .graySchool,
        textColor: UIColor = .graySchool,
        labelText: String = "세부 정보 보기",
        buttonBackgroundColor: UIColor = .clear,
        labelFont: UIFont = UIFont.customFont(forTextStyle: .footnote,
                                              weight: .regular),
        frame: CGRect = .zero
    ) {
        super.init(
            imageName: imageName,
            imageColor: imageColor,
            textColor: textColor,
            labelText: labelText,
            buttonBackgroundColor: buttonBackgroundColor,
            labelFont: labelFont,
            frame: frame
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Custom Show Detail Button Layout
extension CustomShowDetailButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        customLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        customImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(customLabel.snp.trailing).offset(2)
            make.height.equalTo(13)
            make.width.equalTo(7)
        }
    }
}
