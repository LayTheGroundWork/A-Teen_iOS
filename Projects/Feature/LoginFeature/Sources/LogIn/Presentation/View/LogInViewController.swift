//
//  LogInViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol LogInViewControllerCoordinator: AnyObject {
    func didFinish()
    func didSelectSignButton()
}

public final class LogInViewController: UIViewController {    
    // MARK: - Private properties
    private weak var coordinator: LogInViewControllerCoordinator?
    private let viewModel: PhoneNumberViewModel?
    
    private lazy var ateenLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.mainLogo.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var signupTitleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.signupTitle
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .title2, weight: .bold)
        return label
    }()
    
    private lazy var signupSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.signupSubTitle
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .regular)
        label.textColor = DesignSystemAsset.gray02.color
        return label
    }()
    
    private lazy var signupToPhoneButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle(AppLocalized.signupPhoneNumberButton, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = DesignSystemAsset.gray03.color.cgColor
        button.layer.cornerRadius = ViewValues.defaultRadius
        
        return button
    }()
    
    private lazy var agreeTermsGuideLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.agreeTermsGuideTitle
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = DesignSystemAsset.gray02.color
        return label
    }()

    private lazy var bottomBarView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.gray03.color
        return view
    }()
    
    private lazy var loginButton: CustomLoginButton = {
        let button = CustomLoginButton()
        return button
    }()

    private lazy var accountCheckLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.uHaveAccountText
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .regular)
        return label
    }()
    
    // MARK: - Life Cycle
    init(
        coordinator: LogInViewControllerCoordinator?,
        viewModel: PhoneNumberViewModel?
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configAction()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground

        configAgreeTermsGuideLabel()

        let topTextStackView = UIStackView(
            arrangedSubviews: [ateenLogoImage, signupTitleLabel])
        topTextStackView.axis = .horizontal
        topTextStackView.alignment = .top
        topTextStackView.spacing = 7
        
        view.addSubview(topTextStackView)
        view.addSubview(signupSubTitleLabel)
        view.addSubview(signupToPhoneButton)
        view.addSubview(agreeTermsGuideLabel)
        view.addSubview(bottomBarView)
        
        topTextStackView.snp.makeConstraints { make in
            // 상단 네비 생기면, make.top.equalTo(네비.snp.bottom).offset(25)
            make.top.equalToSuperview().offset(105)
            make.centerX.equalToSuperview()
            make.height.equalTo(34)
        }
        
        signupSubTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(topTextStackView.snp.bottom).offset(11)
            make.centerX.equalToSuperview()
        }
        
        signupToPhoneButton.snp.makeConstraints { make in
            make.top.equalTo(signupSubTitleLabel.snp.bottom).offset(34)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(ViewValues.width - 32)
        }
        
        bottomBarView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(85)
        }
        
        agreeTermsGuideLabel.snp.makeConstraints { make in
            make.bottom.equalTo(bottomBarView.snp.top).offset(-27)
            make.centerX.equalToSuperview()
        }
        
        let bottomBarStackView = UIStackView(
            arrangedSubviews: [accountCheckLabel, loginButton])
        bottomBarStackView.axis = .horizontal
        bottomBarStackView.spacing = 10
        
        bottomBarView.addSubview(bottomBarStackView)
        
        bottomBarStackView.snp.makeConstraints { make in
            make.center.equalTo(bottomBarView.snp.center)
        }
    }
    
    private func configAgreeTermsGuideLabel() {
        let attributedStr = NSMutableAttributedString(string: agreeTermsGuideLabel.text!)
        attributedStr.addAttribute(.foregroundColor,
                                   value: UIColor.black,
                                   range: (agreeTermsGuideLabel.text! as NSString).range(of: AppLocalized.koreaText))
        attributedStr.addAttribute(.foregroundColor,
                                   value: UIColor.black,
                                   range: (agreeTermsGuideLabel.text! as NSString).range(of: AppLocalized.serviceTermsText))
        attributedStr.addAttribute(.foregroundColor,
                                   value: UIColor.black,
                                   range: (agreeTermsGuideLabel.text! as NSString).range(of: AppLocalized.userInfoPolicyText))
        agreeTermsGuideLabel.attributedText = attributedStr
    }
    
    // MARK: - Actions
    private func configAction() {
        signupToPhoneButton.addTarget(self,
                         action: #selector(didSelectSignUpButton(_:)),
                         for: .touchUpInside)
        
        loginButton.addTarget(self,
                              action: #selector(didSelectSignInButton(_:)),
                              for: .touchUpInside)
        
    }
}

// MARK: - Extensions
extension LogInViewController {
    @objc func didSelectSignUpButton(_ sender: UIButton) {
        viewModel?.changeSignType(signType: .signUp)
        coordinator?.didSelectSignButton()
    }
    
    @objc func didSelectSignInButton(_ sender: UIButton) {
        viewModel?.changeSignType(signType: .signIn)
        viewModel?.auth.logOut()
        coordinator?.didSelectSignButton()
    }
}
