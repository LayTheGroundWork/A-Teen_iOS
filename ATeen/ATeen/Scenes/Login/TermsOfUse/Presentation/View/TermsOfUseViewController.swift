//
//  TermsOfUseViewController.swift
//  ATeen
//
//  Created by phang on 5/28/24.
//

import SnapKit

import UIKit

protocol TermsOfUseViewControllerCoordinator: AnyObject {
    func didFinish()
    func didSelectNextButton()
}

final class TermsOfUseViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private weak var coordinator: TermsOfUseViewControllerCoordinator?
    
    private lazy var termsOfUseLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.usingTermsText
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .title3,
                                       weight: .bold)
        return label
    }()
    
    private lazy var allAgreeLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.allAgreeText
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout,
                                       weight: .regular)
        return label
    }()
    
    private lazy var serviceTermsLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.serviceTermsAgreeText
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout,
                                       weight: .regular)
        return label
    }()
    
    private lazy var informationAgreeLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.userInfoAgreeText
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout,
                                       weight: .regular)
        return label
    }()
    
    private lazy var alarmAgreeLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.alarmAgreeText
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout,
                                       weight: .regular)
        return label
    }()
    
    private lazy var alarmAgreeExplanationLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.alarmAgreeExplanationText
        label.numberOfLines = 4
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        label.textColor = .gray01
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
        button.setTitle(AppLocalized.nextButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = ViewValues.defaultRadius
        return button
    }()
    
    // MARK: - Life Cycle
    init(coordinator: TermsOfUseViewControllerCoordinator?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        nextButton.addTarget(self,
                             action: #selector(didSelectNextButton(_:)),
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
    
    @objc private func didSelectNextButton(_ sender: UIButton) {
        coordinator?.didSelectNextButton()
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
